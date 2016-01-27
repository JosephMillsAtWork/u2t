#include "loginmanager.h"

#include <QDBusReply>
#include <QDebug>
#include <unistd.h>

LoginManager::LoginManager(QObject *parent)
        : QObject(parent)
        , logind("org.freedesktop.login1", "/org/freedesktop/login1",
          "org.freedesktop.login1.Manager", QDBusConnection::systemBus())
{
    // The shell handles the power buttons, so tell logind to not handle them
    LoginManager::InhibitLocks keyLocks = LoginManager::InhibitPowerKey |
            LoginManager::InhibitSuspendKey | LoginManager::InhibitHibernateKey;
    m_inhibitKeysDescriptor = inhibit(keyLocks, "U2T Shell", "U2T handling keypresses",
            LoginManager::InhibitBlock);
}

LoginManager::~LoginManager() {
    ::close(m_inhibitKeysDescriptor.fileDescriptor());
}

bool LoginManager::canDoAction(const QString &action)
{
    QStringList validValues;
    validValues << QStringLiteral("yes") << QStringLiteral("challenge");

    QDBusReply<QString> reply;

    reply = logind.call(QStringLiteral("Can%1").arg(action));
    return reply.isValid() && validValues.contains(reply.value());
}

bool LoginManager::canPowerOff()
{
    return canDoAction("PowerOff");
}

bool LoginManager::canRestart()
{
    return canDoAction("Reboot");
}

bool LoginManager::canSuspend()
{
    return canDoAction("Suspend");
}

bool LoginManager::canHibernate()
{
    return canDoAction("Hibernate");
}

void LoginManager::restart()
{
    logind.call("Reboot", true);
}

void LoginManager::powerOff()
{
    logind.call("PowerOff", true);
}

void LoginManager::suspend()
{
    logind.call("Reboot", true);
}

void LoginManager::hibernate()
{
    logind.call("PowerOff", true);
}

QDBusUnixFileDescriptor LoginManager::inhibit(InhibitLocks locks, const QString &owner, const QString &reason,
        InhibitMode mode)
{
    QStringList locksList;
    if (locks & LoginManager::InhibitShutdown) {
        locksList << "shutdown";
    }
    if (locks & LoginManager::InhibitSleep) {
        locksList << "sleep";
    }
    if (locks & LoginManager::InhibitIdle) {
        locksList << "idle";
    }
    if (locks & LoginManager::InhibitPowerKey) {
        locksList << "handle-power-key";
    }
    if (locks & LoginManager::InhibitSuspendKey) {
        locksList << "handle-suspend-key";
    }
    if (locks & LoginManager::InhibitHibernateKey) {
        locksList << "handle-hibernate-key";
    }
    if (locks & LoginManager::InhibitLidSwitch) {
        locksList << "handle-lid-switch";
    }

    QString modeString = mode == LoginManager::InhibitBlock ? "block" : "delay";

    QDBusReply<QDBusUnixFileDescriptor> reply;

    reply = logind.call("Inhibit", locksList.join(':'), owner, reason, modeString);

    if (!reply.isValid()) {
        qWarning() << "Unable to request inhibitor locks:" << locksList;
        qWarning() << "Error:" << reply.error().message();
    }

    return reply.value();
}
