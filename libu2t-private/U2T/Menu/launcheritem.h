// This file is part of lipstick, a QML desktop library
//
// This library is free software; you can redistribute it and/or
// modify it under the terms of the GNU Lesser General Public
// License version 2.1 as published by the Free Software Foundation
// and appearing in the file LICENSE.LGPL included in the packaging
// of this file.
//
// This code is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU Lesser General Public License for more details.
//
// Copyright (c) 2011, Robin Burchell
// Copyright (c) 2012, Timur Kristóf <venemo@fedoraproject.org>

#ifndef LAUNCHERITEM_H
#define LAUNCHERITEM_H

#include <QObject>
#include <QStringList>
#include <QSharedPointer>
#include <QDBusInterface>

class MDesktopEntry;

class  LauncherItem : public QObject
{
    Q_OBJECT
//    Q_DISABLE_COPY(LauncherItem)
    Q_PROPERTY(QString filePath READ filePath WRITE setFilePath NOTIFY itemChanged)

    Q_PROPERTY(QStringList categories READ categories  NOTIFY itemChanged)
    Q_PROPERTY(QString comment READ comment  NOTIFY itemChanged)
//    Q_PROPERTY(QString desktopEntry READ desktopEntry NOTIFY itemChanged)
    Q_PROPERTY(QString exec READ exec NOTIFY itemChanged)
    Q_PROPERTY(QString desktopFileName READ desktopFileName NOTIFY itemChanged)
    Q_PROPERTY(QString genericName READ genericName NOTIFY itemChanged)
    Q_PROPERTY(uint hash READ hash NOTIFY itemChanged)
    Q_PROPERTY(bool hidden READ hidden NOTIFY itemChanged)
    Q_PROPERTY(QString icon READ icon NOTIFY itemChanged)
    Q_PROPERTY(bool isValid READ isValid NOTIFY itemChanged)
    Q_PROPERTY(QStringList mimeType READ mimeType NOTIFY itemChanged)
    Q_PROPERTY(QString name READ name NOTIFY itemChanged)
    Q_PROPERTY(QString nameUnlocalized READ nameUnlocalized NOTIFY itemChanged)
    Q_PROPERTY(bool noDisplay READ noDisplay NOTIFY itemChanged)
    Q_PROPERTY(QStringList notShowIn READ notShowIn NOTIFY itemChanged)
    Q_PROPERTY(QStringList onlyShowIn READ onlyShowIn NOTIFY itemChanged)
    Q_PROPERTY(QString path READ path NOTIFY itemChanged)
    Q_PROPERTY(bool startupNotify READ startupNotify NOTIFY itemChanged)
    Q_PROPERTY(QString startupWMClass READ startupWMClass NOTIFY itemChanged)
    Q_PROPERTY(bool terminal READ terminal NOTIFY itemChanged)
    Q_PROPERTY(QString tryExec READ tryExec NOTIFY itemChanged)
    Q_PROPERTY(QString type READ type NOTIFY itemChanged)
    Q_PROPERTY(QString url READ url NOTIFY itemChanged)
    Q_PROPERTY(QString version READ version NOTIFY itemChanged)

    Q_PROPERTY(bool isLaunching READ isLaunching NOTIFY isLaunchingChanged)
    Q_PROPERTY(QStringList getAllFiles READ getAllFiles NOTIFY getAllFilesChanged)


    QSharedPointer<MDesktopEntry> _desktopEntry;
    bool _isLaunching;


public:
    explicit LauncherItem(MDesktopEntry* desktopEntry, QObject *parent = 0);
    explicit LauncherItem(const QString &filePath = QString(), QObject *parent = 0);
    virtual ~LauncherItem();

    QString filePath() const;
    void setFilePath(const QString &filePath);

    QStringList categories()const;
    QString comment()const;
    QString exec()const;
    QString desktopFileName()const;
    QString genericName()const;
    uint hash()const;
    bool hidden()const;
    QString icon()const;
    bool isValid()const;
    QStringList mimeType()const;
    QString name()const;
    QString nameUnlocalized()const;
    bool noDisplay()const;
    QStringList notShowIn()const;
    QStringList onlyShowIn()const;
    QString path()const;
    bool startupNotify()const;
    QString startupWMClass()const;
    bool terminal()const;
    QString tryExec()const;
    QString type()const;
    QString url()const;
    QString version()const;
    bool shouldDisplay() const;
    bool isLaunching() const;

    QStringList getAllFiles();
    void setAllFiles();



    Q_INVOKABLE bool launchApplication(const QString &appId, const QStringList &urls);
    Q_INVOKABLE bool launchDesktopFile(const QString &fileName, const QStringList &urls);
    Q_INVOKABLE bool closeApplication(const QString &appId);
    Q_INVOKABLE bool closeDesktopFile(const QString &fileName);

    Q_INVOKABLE bool addToOpenModel();


    MDesktopEntry* getDesktopEntry();

//    Q_INVOKABLE void launchApplication();
private:
    QStringList m_allFiles;
    QDBusInterface m_interface;


private slots:
    void disableIsLaunching();

signals:
    void itemChanged();
    void isLaunchingChanged();
    void getAllFilesChanged();
};

#endif // LAUNCHERITEM_H
