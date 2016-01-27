#ifndef QQMLPROCESS_H
#define QQMLPROCESS_H
#include <QObject>
#include <QProcess>
#include <QString>
#include <QStringList>
#include <QDebug>
#include <QList>
class QProcess;
class QQmlProcess : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString program READ program WRITE setProgram NOTIFY programChanged)
    Q_PROPERTY(QStringList arguments READ arguments WRITE setArguments NOTIFY argumentsChanged)
    Q_PROPERTY(QString workingDirectory READ workingDirectory WRITE setWorkingDirectory NOTIFY workingDirectoryChanged)

    Q_PROPERTY(bool  isApp READ isApp WRITE setIsApp NOTIFY isAppChanged)
    Q_PROPERTY(bool  startDetached  READ startDetached WRITE setStartDetached)
    Q_PROPERTY(bool running READ running NOTIFY runningChanged)
    Q_PROPERTY(QString getOutPut READ getOutPut NOTIFY getOutPutChanged)
    Q_PROPERTY(ProcessChannelMode processMode READ processMode WRITE setProcessMode NOTIFY processModeChanged)

    Q_ENUMS(ProcessChannelMode)

public:
    explicit QQmlProcess(QObject *parent = 0);


    enum InputChannelMode{
        ManagedInputChannel,
        ForwardedInputChannel
    };
    enum ProcessChannel{
        StandardOutput,
        StandardError
    };
    enum ProcessError{
        FailedToStart,
        Crashed,
        Timedout,
        WriteError,
        ReadError,
        UnknownError
    };
    enum ProcessState{
        NotRunning,
        Starting,
        Running
    };
    enum ProcessChannelMode{
        SeparateChannels,
        MergedChannels,
        ForwardedChannels,
        ForwardedErrorChannel,
        ForwardedOutputChannel
    };
    QString getOutPut()const;

    QString program() const;
    void setProgram(const QString &program);

    QStringList arguments() const;
    void setArguments(const QStringList &arguments);

    QString workingDirectory()const;
    void setWorkingDirectory(const QString &workingDirectory);

    ProcessChannelMode processMode() const;
    void setProcessMode(ProcessChannelMode &processMode);
    bool isApp()const;

    void setIsApp(bool &isApp);
    bool startDetached();
    void setStartDetached(bool startDetached);
    bool running();
    void clear() { m_pendingProcesses.clear(); }
    QProcess::ProcessState state() { return m_process.state(); }

signals:
    void programChanged();
    void argumentsChanged();
    void workingDirectoryChanged();

    void runningChanged();
    void startDetachedChanged();
    void message(QString);
    void error(QString);
    void finished(QString,int);
    void started(QString);
    void isAppChanged();
    void running(bool);
    void getOutPutChanged();

    void processModeChanged(QQmlProcess::ProcessChannelMode);

public slots:
    void stop();
    void start();

protected slots:
    void processStarted();
    void processReadyRead();
    void processFinished(int code);
    void processError(QProcess::ProcessError error);
    void processCmdQueue();

private:
    QProcess m_process;
    QString m_program;
    QStringList m_arguments;
    QString m_workingDirectory;
    QString m_Out;
    QList<QStringList> m_pendingProcesses;
    bool m_isApp;
    bool m_startDetached;
    bool m_running ;
    QString m_getOutPut;
    ProcessChannelMode m_processMode;
protected:
    void close();
    void kill();
};
#endif //QQMLPROCESS_H
