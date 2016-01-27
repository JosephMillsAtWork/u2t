/****************************************************************************
 *
 * Papyros Shell - The desktop shell for Papyros following Material Design
 * Copyright (C) 2015 Michael Spencer <sonrisesoftware@gmail.com>
 *               2015 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *
 * Author(s):
 *    Michael Spencer
 *    Pier Luigi Fiorini
 *
 * $BEGIN_LICENSE:GPL3-PAPYROS-HAWAII$
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3 or any later version accepted
 * by Michael Spencer and Pier Luigi Fiorini, which shall act as a proxy
 * defined in Section 14 of version 3 of the license.
 *
 * Any modifications to this file must keep this entire header intact.
 *
 * The interactive user interfaces in modified source and object code
 * versions of this program must display Appropriate Legal Notices,
 * as required under Section 5 of the GNU General Public License version 3.
 *
 * In accordance with Section 7(b) of the GNU General Public License
 * version 3, these Appropriate Legal Notices must retain the display of the
 * "Powered by Papyros and Hawaii" logo.  If the display of the logo is not
 * reasonably feasible for technical reasons, the Appropriate Legal Notices
 * must display the words "Powered by Papyros and Hawaii".
 *
 * In accordance with Section 7(c) of the GNU General Public License
 * version 3, modified source and object code versions of this program
 * must be marked in reasonable ways as different from the original version.
 *
 * In accordance with Section 7(d) of the GNU General Public License
 * version 3, neither the "Papyros" and "Hawaii" names, nor the names of any
 * project that is related to them, nor the names of their contributors may be
 * used to endorse or promote products derived from this software without
 * specific prior written permission.
 *
 * In accordance with Section 7(e) of the GNU General Public License
 * version 3, this license does not grant any license or rights to use the
 * "Papyros" and "Hawaii" names or logos, nor any other trademark.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * $END_LICENSE$
 ***************************************************************************/
 
#ifndef COMPOSITORLAUNCHER_H
#define COMPOSITORLAUNCHER_H

#include <QObject>

#include <QProcess>

class CompositorLauncher : public QObject
{
    Q_OBJECT

public:
    enum Mode {
        UnknownMode = 0,
        EglFSMode,
        X11Mode,
        WaylandMode
    };

    enum Hardware {
        UnknownHardware = 0,
        DrmHardware,
        BroadcomHardware
    };

    CompositorLauncher(QObject *parent = 0);

    static CompositorLauncher *instance();

    Mode mode() const { return m_mode; }
    void setMode(const Mode &mode) { m_mode = mode; }

public slots:

    void start();
    void stop();

signals:
    void started();
    void stopped();

private:
    Mode m_mode;
    Hardware m_hardware;
    bool m_hasLibInputPlugin;

    QProcess *m_process;

    void detectMode();
    void detectHardware();

    QString deviceModel() const;
    bool pathsExist(const QStringList &paths) const;

    void detectLibInput();

    QStringList compositorArgs() const;
    QProcessEnvironment compositorEnv() const;

    void startProcess(const QString &command, const QStringList &args,
            QProcessEnvironment environment);

    void setupEnvironment();
};

#endif // COMPOSITORLAUNCHER_H
