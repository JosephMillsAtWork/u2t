#include "qmlprocess.h"
/*!
    \qmltype QQmlProcess
    \inqmlmodule U2T.
    \ingroup U2T.System
    \since 5.3
    \brief  Qml Plugin to run extrenal commands and or applicaions.

    Contains classes for running extrenal apps or commands from QML .

    The QQmlProcess module provides classes to
    run extrneal applcations and or commands from within qml

    This is a QML plugin.  One can read the output and there command
    also many different qmlsignals that get used in this modual.

*/

QQmlProcess::QQmlProcess(QObject *parent) :
    QObject(parent),
    m_isApp(false),
    m_startDetached(false)
{
    connect(&m_process,SIGNAL(readyReadStandardError()),this,SLOT(processReadyRead()));
    connect(&m_process,SIGNAL(started()),this,SLOT(processStarted()));
    connect(&m_process,SIGNAL(finished(int)),this,SLOT(processFinished(int)));
    connect(&m_process,SIGNAL(readyRead()),this,SLOT(processReadyRead()));
    connect(&m_process,SIGNAL(error(QProcess::ProcessError)),this,SLOT(processError(QProcess::ProcessError)));
}

/*!
    \qmlproperty string QQmlProcess::appName
    used in qml to set a QQmlProcess name and or command.
    Example:
    \code
    QQmlProcess{
        program: "vlc"
    }
    \endcode
*/

QString QQmlProcess::program() const
{
    return m_program;
}

/*!
  \qmlproperty string QQmlProcess::setAppName
  used to set the QQmlProcesss and or command from the c++ side of things
 */
void QQmlProcess::setProgram(const QString &program)
{
    if(m_program == program)
        return;

    m_program = program;
    emit programChanged();
}

/*!
  \qmlproperty array QQmlProcess::arguments
  set arguments to a command.  This is only used when running commands and need to add
  extra arguments to the command. Please see isApp.
  All white spaces sould be escaped
  \code
  QQmlProcess {
      program: "tar"
      arguments: ['-czf', 'some.tar.gz', 'some/folder'
  }
  \endcode
*/
QStringList QQmlProcess::arguments() const
{
    return m_arguments;
}

/*!
  \qmlproperty string QQmlProcess::setArguments
  used on the c++ side of things to set the appliction arguments
 */
void QQmlProcess::setArguments(const QStringList &arguments)
{
    if(m_arguments == arguments)
        return;
    m_arguments = arguments;
    emit argumentsChanged();
}

QString QQmlProcess::workingDirectory() const
{
    return m_workingDirectory;
}

void QQmlProcess::setWorkingDirectory(const QString &workingDirectory)
{
    if (m_workingDirectory == workingDirectory)
        return;
    m_workingDirectory = workingDirectory;
    emit workingDirectoryChanged();
}


/*!
  \qmlproperty bool QQmlProcess::isApp

  bool property that is used in qml to tell the QQmlProcess module if it is a QQmlProcess or a command

 Example For a QQmlProcess:
  \code
  QQmlProcess{
    isApp: true
    appName: "vlc"
    }
\endcode

Example for a command:
  \code
  QQmlProcess {
    isApp: false
    appName: "echo\ \"Hello\ World\""
     }
  \endcode
 */

bool QQmlProcess::isApp()const
{
    return m_isApp;
}


/*!
  \qmlproperty bool QQmlProcess::setIsApp

  used on the cpp side of things to set the isApp parma
 */
void QQmlProcess::setIsApp(bool &isApp)
{
    if (m_isApp == isApp)
        return;
    m_isApp = isApp;
    emit isAppChanged();
}

/*!
 \qmlproperty bool QQmlProcess::startDetached

  qml property to tell the QQmlProcess if it should be launched extrenal and not intrenal with in the qml app. default is set to false
 */
bool QQmlProcess::startDetached()
{
    return m_startDetached;
}

/*!
 \qmlproperty bool QQmlProcess::setStartDetached

  used on the cpp side of things to set startDetached in QML
 */

void QQmlProcess::setStartDetached(bool startDetached)
{
    if (m_startDetached == startDetached)
        return;

    m_startDetached = startDetached;
    emit startDetachedChanged();
}

/*!
  \qmlproperty bool QQmlProcess::running

  returns true if a QQmlProcess and or command is running
  returns false if it is not.
  can be put on qml signals also

 \code
    QQmlProcess {
        ...
        .......
        onRunning: console.log("I am a running QQmlProcess " + appName )
    }
  \endcode
*/

bool QQmlProcess::running()
{
    if(m_process.state() != 0)
    {
        m_running = true;
        return m_running;
    }
    else
    {
        m_running = false ;
        return m_running;
    }
}

/*!
 * \qmlsignal QQmlProcess::getOutPut()

  a function that is used to return the output (string) of the command or program that is curently running.
  \code
  QQmlProcess{
        id: applauncher
        ....
        .......
  }
  Button{
     onClicked: applauncher.running ? console.log("the debug message of the extrenal app " applauncher.getOutPut() ) : console.log("the QQmlProcess " + applauncher.appName + " Is not running ")
  }
  \endcode
 */

QString QQmlProcess::getOutPut() const
{
    return m_getOutPut;
}

QQmlProcess::ProcessChannelMode QQmlProcess::processMode() const{
    return m_processMode ;
}

void QQmlProcess::setProcessMode(QQmlProcess::ProcessChannelMode &processMode){
    if (m_processMode == processMode)
        return ;
    m_processMode = processMode;
    if (m_processMode == QQmlProcess::SeparateChannels)
    {
        m_process.setProcessChannelMode(QProcess::SeparateChannels);
        emit processModeChanged(QQmlProcess::SeparateChannels);
    }
    else if (m_processMode == QQmlProcess::MergedChannels)
    {
        m_process.setProcessChannelMode(QProcess::MergedChannels);
        emit processModeChanged(QQmlProcess::MergedChannels);

    }
    else if (m_processMode == QQmlProcess::ForwardedChannels)
    {
        m_process.setProcessChannelMode(QProcess::ForwardedChannels);
        emit processModeChanged(QQmlProcess::ForwardedChannels);

    }
    else if (m_processMode == QQmlProcess::ForwardedErrorChannel)
    {
        m_process.setProcessChannelMode(QProcess::ForwardedErrorChannel);
        emit processModeChanged(QQmlProcess::ForwardedErrorChannel);

    }
    else if (m_processMode == QQmlProcess::ForwardedOutputChannel)
    {
        m_process.setProcessChannelMode(QProcess::ForwardedOutputChannel);
        emit processModeChanged(QQmlProcess::ForwardedOutputChannel);

    }
    //        m_process.setProcessChannelMode(m_processMode);
    emit processModeChanged(processMode);
}


/*!
  \qmlsignal  QQmlProcess::close()
  used to close the QQmlProcess and or command nicley
 */
void QQmlProcess::close() {
    m_process.close();
    m_process.waitForFinished();
    emit running(false);
}

/*!
 \qmlsignal QQmlProcess::stop()
  Used to stop the QQmlProcess.  This is used only if close is not working

 \b{See Also} kill()
 */
void QQmlProcess::stop() {
    kill();
    emit running(false);
}

/*!
 * \qmlsignal QQmlProcess::processStarted()
  used to tell the user if the command and or QQmlProcess has started
 */
void QQmlProcess::processStarted() {
    emit started(m_process.program());
    emit running(true);
}
/*!
  \qmlsignal  QQmlProcess::kill()
   used to kill a QQmlProcess that is not responding. also see close() and stop()
 */
void QQmlProcess::kill() {
    this->clear();
    m_process.kill();
    m_process.waitForFinished();
    emit running(false);
}

/*!
 * \qmlsignal QQmlProcess::processError()
 *
 * used to qmlsignal to qml if there is a error that happens and returns the error string to QML
 */

void QQmlProcess::processError(QProcess::ProcessError err) {
    Q_UNUSED(err);
    if (m_process.exitCode() == 0) { return; }
    emit error(QString(QLatin1String("ERROR: (%0) %1")).arg(m_program).arg(m_process.errorString()));
    m_pendingProcesses.clear();
    emit running(false);
}


/*!
  \qmlsignal QQmlProcess::start()

  used to start the QQmlProcess and or command
  Example
  \code
  QQmlProcess{
       id: app
       isApp: true
       program: "echo"
       arguments:["\"Hello", "World\""]

  }
  Button{
       onClicked: app.start();
  }
  \endcode
 */
void QQmlProcess::start() {
    processCmdQueue();
    emit running(true);
}

/*!
 * \qmlsignal QQmlProcess::processFinished()

  used to tell QML if the QQmlProcess and or command is done and finshed. see also finshed()
 */
void QQmlProcess::processFinished(int code) {
    if (code != 0) {
        emit error(QString(QLatin1String(m_process.readAllStandardError())));
        m_pendingProcesses.clear();
        emit running(false);
        return;
    }
    QString errorMsg = QString::fromLatin1(m_process.readAllStandardError());
    if (errorMsg.trimmed().length()>0) emit error(errorMsg);
    QString msg = QString::fromLatin1(m_process.readAllStandardOutput());
    if (msg.trimmed().length()>0) emit message(msg);
    emit finished(m_process.program(), code);
    emit running(false);
}

/*!
 \qmlsignal QQmlProcess::processReadyRead()

  Used by Qml to tell if the QQmlProcess and or command is ready to start reading the output.

  \b{See also} message() getOutPut()
 */
void QQmlProcess::processReadyRead() {
    QString stderr = QString::fromLatin1(m_process.readAllStandardError());
    QString stdout = QString::fromLatin1(m_process.readAll());

    if (!stderr.isEmpty()) {
        m_getOutPut = stderr;
        emit message(stderr);
        emit running(false);
    }
    if (!stdout.isEmpty()) {
        m_getOutPut = "";
        m_getOutPut = stdout;
        emit getOutPutChanged();
        emit message(stdout);
        emit running(false);
    }
}







void QQmlProcess::processCmdQueue() {

    m_process.setProperty("command",m_program);

    // check to see if we have arguments
    if(m_arguments.length() > 0){
        m_process.setArguments(m_arguments);
    }
    if (m_isApp) {
        m_process.start(m_program,m_arguments);
    }
    else if ( m_startDetached )  {
        m_process.startDetached(m_program,m_arguments);
        qDebug() << "Just Started a app here is some info about it "
                 << m_process.processId();
    }
                    else {
                    m_process.execute(m_program,m_arguments);
    }
    }
