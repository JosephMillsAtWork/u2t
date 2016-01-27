#include "sessionadaptor.h"
#include "sessionmanager.h"

SessionAdaptor::SessionAdaptor(SessionManager *sessionManager)
    : QDBusAbstractAdaptor(sessionManager)
    , m_sessionManager(sessionManager)
    , m_loginManager(new LoginManager)
{
    // // Relay session locked/unlocked signals
    // connect(m_loginManager, &LoginManager::sessionLocked, this, [this] {
    //     if (!m_sessionManager->isLocked()) {
    //         m_sessionManager->setLocked(true);
    //         Q_EMIT lockedChanged();
    //     }
    //
    //     Q_EMIT sessionLocked();
    // });
    // connect(m_loginManager, &LoginManager::sessionUnlocked, this, [this] {
    //     if (m_sessionManager->isLocked()) {
    //         m_sessionManager->setLocked(false);
    //         Q_EMIT lockedChanged();
    //     }
    //
    //     Q_EMIT sessionUnlocked();
    // });
    //
    // // Logout session before the system goes off
    // connect(m_loginManager, &LoginManager::logOutRequested,
    //         this, &SessionAdaptor::logOut);
    //
    // // Set idle
    // connect(m_sessionManager, &SessionManager::idleChanged, this, [this](bool value) {
    //     m_loginManager->setIdle(value);
    // });
}

bool SessionAdaptor::isLocked() const
{
    return m_sessionManager->isLocked();
}

bool SessionAdaptor::canLock()
{
    // TODO: Load from KConfig
    return true;
}

bool SessionAdaptor::canLogOut()
{
    // TODO: Load from KConfig
    return true;
}

bool SessionAdaptor::canStartNewSession()
{
    // Always false, but in the future we might consider
    // allowing this
    return false;
}

bool SessionAdaptor::canPowerOff()
{
    return m_loginManager->canPowerOff();
}

bool SessionAdaptor::canRestart()
{
    return m_loginManager->canRestart();
}

bool SessionAdaptor::canSuspend()
{
    return m_loginManager->canSuspend();
}

bool SessionAdaptor::canHibernate()
{
    return m_loginManager->canHibernate();
}

void SessionAdaptor::lockSession()
{
    // m_loginManager->lockSession();
}

void SessionAdaptor::unlockSession()
{
    // m_loginManager->unlockSession();
}

void SessionAdaptor::startNewSession()
{
    // Not supported yet
}

void SessionAdaptor::activateSession(int index)
{
    // m_loginManager->switchToVt(index);
}

void SessionAdaptor::logOut()
{
    m_sessionManager->logOut();
}

void SessionAdaptor::powerOff()
{
    m_loginManager->powerOff();
}

void SessionAdaptor::restart()
{
    m_loginManager->restart();
}

void SessionAdaptor::suspend()
{
    m_loginManager->suspend();
}

void SessionAdaptor::hibernate()
{
    m_loginManager->hibernate();
}

#include "moc_sessionadaptor.cpp"
