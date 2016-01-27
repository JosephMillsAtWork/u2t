#ifndef SESSIONADAPTOR_H
#define SESSIONADAPTOR_H

#include <QDBusAbstractAdaptor>

#include "loginmanager.h"
#include "sessionmanager.h"

class SessionAdaptor : public QDBusAbstractAdaptor
{

    Q_OBJECT
    Q_CLASSINFO("D-Bus Interface", "io.u2t.session")
    Q_PROPERTY(bool locked READ isLocked NOTIFY lockedChanged)

public:
    SessionAdaptor(SessionManager *sessionManager);

    bool isLocked() const;

signals:
    void idleChanged();
    void lockedChanged();
    void sessionLocked();
    void sessionUnlocked();

public slots:
    bool canLock();
    bool canStartNewSession();
    bool canLogOut();
    bool canPowerOff();
    bool canRestart();
    bool canSuspend();
    bool canHibernate();

    Q_NOREPLY void lockSession();
    Q_NOREPLY void unlockSession();

    Q_NOREPLY void startNewSession();

    Q_NOREPLY void activateSession(int index);

    Q_NOREPLY void logOut();
    Q_NOREPLY void powerOff();
    Q_NOREPLY void restart();
    Q_NOREPLY void suspend();
    Q_NOREPLY void hibernate();

private:
    SessionManager *m_sessionManager;
    LoginManager *m_loginManager;
};

#endif // SESSIONADAPTOR_H
