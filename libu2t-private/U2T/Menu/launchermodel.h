/****************************************************************************
 * This file is part of Hawaii Shell.
 *
 * Copyright (C) 2014 Pier Luigi Fiorini
 *               2015 2015 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * Author(s):
 *    Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *    Michael Spencer <sonrisesoftware@gmail.com>
 *
 * $BEGIN_LICENSE:LGPL2.1+$
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 2.1 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * $END_LICENSE$
 ***************************************************************************/

#ifndef LAUNCHERMODEL_H
#define LAUNCHERMODEL_H

#include <QtCore/QAbstractListModel>
#include <QtQml/QQmlComponent>
#include <KConfigCore/KConfig>
#include <KConfigCore/KSharedConfig>

class Application;

class LauncherModel : public QAbstractListModel
{
    Q_OBJECT

    Q_ENUMS(Roles)

public:
    enum Roles {
        AppIdRole = Qt::UserRole + 1,
        DesktopFileRole,
        ActionsRole,
        StateRole,
        RunningRole,
        FocusedRole,
        PinnedRole
    };

    LauncherModel(bool includePinnedApps, QObject *parent = 0);
    ~LauncherModel();

    static QObject *launcherSingleton(QQmlEngine *engine, QJSEngine *scriptEngine);

    static QObject *switcherSingleton(QQmlEngine *engine, QJSEngine *scriptEngine);

    QHash<int, QByteArray> roleNames() const;

    int rowCount(const QModelIndex &parent = QModelIndex()) const;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;

    Q_INVOKABLE Application *get(int index) const;
    Q_INVOKABLE int indexFromAppId(const QString &appId) const;

    Q_INVOKABLE void pin(const QString &appId);
    Q_INVOKABLE void unpin(const QString &appId);

private:
    QList<Application *> m_list;
    KSharedConfigPtr m_config;
    bool m_includePinnedApps;

    QStringList defaultPinnedApps();

    void pinLauncher(const QString &appId, bool pinned);

    bool moveRows(int sourceRow, int count, int destinationChild);
    bool moveRows(const QModelIndex & sourceParent, int sourceRow, int count, const QModelIndex & destinationParent, int destinationChild) Q_DECL_OVERRIDE;
};

QML_DECLARE_TYPE(LauncherModel)

#endif // LAUNCHERMODEL_H
