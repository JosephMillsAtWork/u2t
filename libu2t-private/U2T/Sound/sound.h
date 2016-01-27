#ifndef VOLUMECONTROL_H
#define VOLUMECONTROL_H

#include <QQuickItem>

class Backend
{
public:
    virtual ~Backend() {}

    virtual void getBoundaries(int *min, int *max) const = 0;
    virtual int rawVol() const = 0;
    virtual void setRawVol(int vol) = 0;
    virtual bool muted() const = 0;
    virtual void setMuted(bool muted) = 0;
};

class Sound : public QQuickItem
{
    Q_OBJECT

    Q_PROPERTY(int master READ master WRITE setMaster NOTIFY masterChanged)
    Q_PROPERTY(bool muted READ muted WRITE setMuted NOTIFY mutedChanged)

public:
    Sound(QQuickItem *parent = 0);
    ~Sound();

    void init();

    int master() const;
    bool muted() const;
    void setMuted(bool muted);

public slots:
    void increaseMaster();
    void decreaseMaster();
    void setMaster(int master);
    void changeMaster(int change);
    void toggleMuted();

signals:
    void masterChanged();
    void mutedChanged();
    void bindingTriggered();

private:
    int m_min;
    int m_max;
    int m_step;

    Backend *m_backend;
};

#endif
