/*
 * Copyright 2013 Canonical Ltd.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * Author: Lars Uebernickel <lars.uebernickel@canonical.com>
 */

#include "gsettings-qml.h"
#include <QGSettings>

struct GSettingsSchemaQmlPrivate
{
    QByteArray id;
    QByteArray path;
    bool isValid;

    GSettingsSchemaQmlPrivate() : isValid(false) {}
};

struct GSettingsQmlPrivate
{
    GSettingsSchemaQml *schema;
    QGSettings *settings;
};

GSettingsSchemaQml::GSettingsSchemaQml(QObject *parent): QObject(parent)
{
    priv = new GSettingsSchemaQmlPrivate;
}

GSettingsSchemaQml::~GSettingsSchemaQml()
{
    delete priv;
}

QByteArray GSettingsSchemaQml::id() const
{
    return priv->id;
}

void GSettingsSchemaQml::setId(const QByteArray &id)
{
    if (!priv->id.isEmpty()) {
        qWarning("GSettings.schema.id may only be set on construction");
        return;
    }

    priv->id = id;
}

QByteArray GSettingsSchemaQml::path() const
{
    return priv->path;
}

void GSettingsSchemaQml::setPath(const QByteArray &path)
{
    if (!priv->path.isEmpty()) {
        qWarning("GSettings.schema.path may only be set on construction");
        return;
    }

    priv->path = path;
}



bool GSettingsSchemaQml::isValid() const
{
    return priv->isValid;
}

void GSettingsSchemaQml::setIsValid(bool valid)
{
    if (valid != priv->isValid) {
        priv->isValid = valid;
        Q_EMIT isValidChanged();
    }
}

QVariantList GSettingsSchemaQml::choices(const QByteArray &key) const
{
    GSettingsQml *parent = (GSettingsQml *) this->parent();

    if (parent->priv->settings == NULL)
        return QVariantList();

    if (!parent->contains(key))
        return QVariantList();

    return parent->priv->settings->choices(key);
}

void GSettingsSchemaQml::reset(const QByteArray &key)
{
    GSettingsQml *parent = (GSettingsQml *) this->parent();

    if (parent->priv->settings != NULL) {
        parent->priv->settings->reset(key);

        // make sure this object gets the new value immediately and not on the
        // next main loop iteration (see updateValue)
        parent->settingChanged(key);
    }
}

GSettingsQml::GSettingsQml(QObject *parent): QQmlPropertyMap(this, parent)
{
    priv = new GSettingsQmlPrivate;
    priv->schema = new GSettingsSchemaQml(this);
    priv->settings = NULL;
}

GSettingsQml::~GSettingsQml()
{
    delete priv;
}

GSettingsSchemaQml * GSettingsQml::schema() const
{
    return priv->schema;
}

void GSettingsQml::classBegin()
{
}



QString GSettingsQml::all()
{
    return m_all;
}

void GSettingsQml::getAll()
{

//    GSettingsQmlPrivate.schema->dumpObjectTree();
    QProcess m_process;
    QStringList m_arg;
    QString cmd;
    cmd = "gsettings";
    m_arg << "list-schemas";
    m_process.setArguments(m_arg);
    m_process.start(cmd,m_arg);
    m_process.waitForFinished();
    QString out;
    while (!m_process.atEnd()) {
        out.append(m_process.readLine().append(",") );
    }
    if(m_all  ==  out)
        return ;
    m_all = out;
}



void GSettingsQml::componentComplete()
{
    bool schemaValid = QGSettings::isSchemaInstalled(priv->schema->id());
    if (schemaValid) {
        priv->settings = new QGSettings(priv->schema->id(), priv->schema->path(), this);

        connect(priv->settings, SIGNAL(changed(const QString &)), this, SLOT(settingChanged(const QString &)));

        Q_FOREACH(const QString &key, priv->settings->keys())
            this->insert(key, priv->settings->get(key));

        Q_EMIT(schemaChanged());
    }
    // emit isValid notification only once everything is setup
    priv->schema->setIsValid(schemaValid);
}

void GSettingsQml::settingChanged(const QString &key)
{
    QVariant value = priv->settings->get(key);
    if (this->value(key) != value) {
        this->insert(key, value);
        Q_EMIT(changed(key, value));
    }
}

QVariant GSettingsQml::updateValue(const QString& key, const QVariant &value)
{
    if (priv->settings == NULL)
        return QVariant();

    if (priv->settings->trySet(key, value)) {
        // due to QTBUG-32859, QGSettings doesn't dispatch its changed signal
        // directly, but on a new main loop iteration. At that point, this
        // object already has the new value set and doesn't emit its own
        // changed signal (see ::settingChanged). Emit it here so that it is
        // sent even when the setting is changed from qml.
        Q_EMIT(changed(key, value));

        return value;
    }
    else {
        qWarning("unable to set key '%s' to value '%s'", key.toUtf8().constData(), value.toString().toUtf8().constData());
        return priv->settings->get(key);
    }
}
