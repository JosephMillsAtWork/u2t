#ifndef ICONSFINDER_H
#define ICONSFINDER_H

#include <QObject>

#include <QIcon>
#include <QPixmap>

#include <QDir>
#include <QFile>
#include <QFileInfo>
#include <QString>
#include <QStringList>
#include <QTextStream>
#include <QDebug>


class IconsFinder : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QStringList iconThemeList READ iconThemeList NOTIFY iconThemeListChanged)
    Q_PROPERTY(QStringList cursorList READ cursorList NOTIFY cursorListChanged)
    Q_PROPERTY(QString currentIcon READ currentIcon NOTIFY currentIconChanged)


public:
    explicit IconsFinder(QObject *parent = 0);

    QStringList iconThemeList()const;

    // init

    void initIconClass();

    QStringList cursorList()const ;

    QString currentIcon()const;

    Q_INVOKABLE void setCurrentIcon(const QString iconTheme);
    Q_INVOKABLE void setIconTheme(const QString iconTheme);
    Q_INVOKABLE void setCursorTheme(const QString cursorTheme);

signals:
    void iconThemeListChanged();
    void cursorListChanged();
    void currentIconChanged();
    void initIconTheme(QStringList);
    void initCursorTheme(QStringList);

protected slots:
    void setIconThemeList(const QStringList iconThemeList);
    void setCursorThemeList(const QStringList cursorThemeList);

private :
    QStringList m_iconThemeList;
    QStringList m_cursorThemeList;
    QString m_currentIcon;


};

#endif // ICONSFINDER_H
