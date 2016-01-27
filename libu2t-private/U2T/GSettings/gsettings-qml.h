#include <QtQml>
#include <QQmlParserStatus>
#include <QProcess>

class GSettingsSchemaQml: public QObject
{
    Q_OBJECT
    Q_PROPERTY(QByteArray id      READ id      WRITE setId)
    Q_PROPERTY(QByteArray path    READ path    WRITE setPath)
    Q_PROPERTY(bool       isValid READ isValid NOTIFY isValidChanged)
public:
    GSettingsSchemaQml(QObject *parent = NULL);
    ~GSettingsSchemaQml();

    QByteArray id() const;
    void setId(const QByteArray &id);

    QByteArray path() const;
    void setPath(const QByteArray &path);



    bool isValid() const;
    void setIsValid(bool valid);

    Q_INVOKABLE QVariantList choices(const QByteArray &key) const;
    Q_INVOKABLE void reset(const QByteArray &key);

Q_SIGNALS:
    void isValidChanged();

private:
    struct GSettingsSchemaQmlPrivate *priv;
};

class GSettingsQml: public QQmlPropertyMap, public QQmlParserStatus
{
    Q_OBJECT
    Q_INTERFACES(QQmlParserStatus)
    Q_PROPERTY(GSettingsSchemaQml* schema READ schema NOTIFY schemaChanged)
    Q_PROPERTY(QString all READ all)

public:
    GSettingsQml(QObject *parent = NULL);
    ~GSettingsQml();
    Q_INVOKABLE void getAll();

    GSettingsSchemaQml * schema() const;

    QString all();

    void classBegin();
    void componentComplete();

Q_SIGNALS:
    void schemaChanged();
    void changed (const QString &key, const QVariant &value);

private Q_SLOTS:
    void settingChanged(const QString &key);

private:
    QString m_all;

    struct GSettingsQmlPrivate *priv;

    QVariant updateValue(const QString& key, const QVariant &value);

    friend class GSettingsSchemaQml;
};
