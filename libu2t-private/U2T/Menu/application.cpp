#include <GreenIsland/Server/ApplicationManager>
#include <QtCore/QLocale>
#include <QtCore/QStandardPaths>
#include <QtCore/QDebug>
#include <QtDBus/QDBusConnection>
#include <QtDBus/QDBusInterface>

#include "application.h"

Application::Application(const QString &appId, bool pinned, QObject *parent)
		: QObject(parent), m_appId(appId),
		  m_focused(false), m_pinned(pinned),
		  m_state(Application::NotRunning)
{
	m_desktopFile = new DesktopFile(appId, this);
}

Application::Application(const QString &appId, QObject *parent)
		: Application(appId, false, parent)
{
}

void Application::setPinned(bool pinned)
{
	if (pinned == m_pinned)
		return;

	m_pinned = pinned;
	emit pinnedChanged();
}

void Application::setState(State state)
{
	if (state == m_state)
		return;

	m_state = state;
	emit stateChanged();
}

void Application::setFocused(bool focused)
{
	if (focused == m_focused)
		return;

	m_focused = focused;
	emit focusedChanged();
}

bool Application::launch(const QStringList& urls)
{
	if (isRunning())
        return true;

    desktopFile()->launch(urls);

    Q_EMIT launched();

    return true;
}

bool Application::quit()
{
	if (!isRunning())
        return false;

    GreenIsland::ApplicationManager::instance()->quit(appId());

    return true;
}
