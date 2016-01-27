#include <QtCore/QCoreApplication>
#include <QtCore/QCommandLineParser>
#include <QDebug>
#include "compositorlauncher.h"
#include "sessionmanager.h"

#include "sigwatch.h"

#include <unistd.h>

#define TR(x) QT_TRANSLATE_NOOP("Command line parser", QStringLiteral(x))

int main(int argc, char *argv[])
{
    // Application
    QCoreApplication app(argc, argv);
    app.setApplicationName(QStringLiteral("U2T Shell"));
    app.setApplicationVersion(QStringLiteral("1.0.0"));
    app.setOrganizationName(QStringLiteral("U2T"));

    // Restart with D-Bus session if necessary
    if (qEnvironmentVariableIsEmpty("DBUS_SESSION_BUS_ADDRESS")) {
        qDebug() << "No D-Bus session bus available, respawning with dbus-launch...";

        QStringList args = QStringList()
                << QStringLiteral("--exit-with-session")
                << QCoreApplication::arguments();

        char **const argv_pointers = new char *[args.count() + 2];
        char **p = argv_pointers;

        *p = ::strdup("dbus-launch");
        ++p;

        for (const QString &arg: args) {
            *p = new char[arg.length() + 1];
            ::strcpy(*p, qPrintable(arg));
            ++p;
        }

        *p = 0;

        // Respawn with D-Bus session bus
        if (::execvp(argv_pointers[0], argv_pointers) == -1) {
            // If we are here execvp failed so we cleanup and bail out
            qWarning("Failed to respawn the session: %s", strerror(errno));

            p = argv_pointers;
            while (*p != 0)
                delete [] *p++;
            delete [] argv_pointers;

            ::exit(EXIT_FAILURE);
        }

        ::exit(EXIT_SUCCESS);
    }

    CompositorLauncher *launcher = CompositorLauncher::instance();

    // Session manager
    SessionManager *sessionManager = SessionManager::instance();
    if (!sessionManager->initialize())
        return 1;

    // Unix signals watcher
    UnixSignalWatcher sigwatch;
    sigwatch.watchForSignal(SIGINT);
    sigwatch.watchForSignal(SIGTERM);

    // Log out the session for SIGINT and SIGTERM
    QObject::connect(&sigwatch, &UnixSignalWatcher::unixSignal, [sessionManager](int signum) {
        qDebug() << "Log out caused by signal" << signum;
        sessionManager->logOut();
    });


    // Start the compositor
    launcher->start();

    return app.exec();
}
