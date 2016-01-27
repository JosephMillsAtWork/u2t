/*
 * Papyros Shell - The desktop shell for Papyros following Material Design
 *
 * Copyright (C) 2015 Bogdan Cuza <bogdan.cuza@hotmail.com>
 *               2015 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as
 * published by the Free Software Foundation, either version 2.1 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef SESSIONMANAGER_H
#define SESSIONMANAGER_H

#include <QObject>

#include <QDBusInterface>
#include <QQmlEngine>
#include <QJSEngine>
#include <QProcess>

struct pam_message;
struct pam_response;

class SessionManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool canPowerOff MEMBER m_canPowerOff CONSTANT)
    Q_PROPERTY(bool canRestart MEMBER m_canRestart CONSTANT)
    Q_PROPERTY(bool canSuspend MEMBER m_canSuspend CONSTANT)
    Q_PROPERTY(bool canHibernate MEMBER m_canHibernate CONSTANT)
    Q_PROPERTY(bool canLogOut MEMBER m_canLogOut CONSTANT)

public:
    SessionManager(QObject *parent = 0);

    static QObject *qmlSingleton(QQmlEngine *engine, QJSEngine *scriptEngine);

public slots:
    bool canPowerOff() const { return m_canPowerOff; }
    bool canRestart() const { return m_canRestart; }
    bool canSuspend() const { return m_canSuspend; }
    bool canHibernate() const { return m_canHibernate; }
    bool canLogOut() const { return m_canLogOut; }

    void powerOff();
    void restart();
    void suspend();
    void hibernate();
    void logOut();

    void authenticate(const QString &password);

signals:
    void authenticationSucceeded();
    void authenticationFailed();
    void authenticationError();

private:
    QDBusInterface m_interface;
    pam_response *m_response;
    bool m_canPowerOff;
    bool m_canRestart;
    bool m_canSuspend;
    bool m_canHibernate;
    bool m_canLogOut;

    bool canDoAction(const QString &action);

    static int conversationHandler(int num, const pam_message **message,
                                   pam_response **response, void *data);

};

#endif // SESSIONMANAGER_H
