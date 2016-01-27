#ifndef TEXTTOSPEECH_H
#define TEXTTOSPEECH_H

#include <QString>
#include <QObject>
#include <QStringList>
#include <QDebug>
#include <QVector>
#include <QLocale>
#include <QTextToSpeech>

class  TextToSpeech: public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString text READ text WRITE setText NOTIFY textChanged)
    Q_PROPERTY(int rate READ rate WRITE setRate NOTIFY rateChanged)
    Q_PROPERTY(int pitch READ pitch WRITE setPitch NOTIFY pitchChanged)
    Q_PROPERTY(int language READ language WRITE setLanguage NOTIFY languageChanged)
    Q_PROPERTY(int voice READ voice WRITE setVoice NOTIFY voiceChanged)
//    Q_PROPERTY(int volume READ volume WRITE setVolume NOTIFY volumeChanged)
    Q_PROPERTY(QStringList engines READ engines NOTIFY enginesChanged)
    Q_PROPERTY(QStringList voices READ voices NOTIFY voicesChanged)
    Q_PROPERTY(QStringList languages READ languages NOTIFY languagesChanged)

    Q_PROPERTY(State state READ state NOTIFY stateChanged)
    Q_ENUMS(State)
public:
   explicit TextToSpeech(QObject *parent = 0);

    enum State {
        Ready,
        Speaking,
        Paused,
        BackendError,
        Default
    };
    State state();

//getters and settters
   QString text();
   void setText(const QString &text);

   int pitch();
   void setPitch(int &pitch);

   int rate();
   void setRate(int &rate);

   int language();
   void setLanguage(const int &language);

   int voice();
   void setVoice(const int &voice);

//   int volume();
//   void setVolume(const int &volume);


//INIT setups for lists
   QStringList engines();
   void setupEngines();

   QStringList languages();
   void setupLanguages();

   QStringList voices();
   void setupVoices();

   Q_INVOKABLE void speak();
   Q_INVOKABLE void stop();
   Q_INVOKABLE void pause();
   Q_INVOKABLE void resume();

signals:
   void textChanged();
   void rateChanged();
   void pitchChanged();
   void stateChanged();
   void languageChanged();
   void voiceChanged();
   void enginesChanged();
   void voicesChanged();
   void languagesChanged();

//   void volumeChanged();

public slots:
    void handelStateChange(QTextToSpeech::State state);

private:
    QTextToSpeech *m_speech;
    QVector<QVoice> m_vs;
    QString m_text;
    int m_rate;
    int m_pitch;

    State m_state;
    QTextToSpeech::State mm_state;

    int m_language;
    int m_voice;
//    int m_volume;

    QStringList m_voices;
    QStringList m_languages;
    QStringList m_engines;

};

#endif // TEXTTOSPEECH_H
