#include "texttospeech.h"





//FIXME make so that th user sets the tranlation type from qml
TextToSpeech::TextToSpeech(QObject *parent) :
    QObject(parent),
    m_speech(new QTextToSpeech(this)),
    m_rate(0),
    m_pitch(0),
    m_state(Default)
//    m_volume(50)
{

    connect(m_speech,SIGNAL(stateChanged(QTextToSpeech::State)),
            this,SLOT(handelStateChange(QTextToSpeech::State)) );

    setupEngines();
    setupLanguages();
    setupVoices();
}
/*!
 \qmlenum  TextToSpeech::state

 This property holds the current state of the speech synthesizer. Use speak() to start synthesizing text with the current voice and locale.


Ready:  The Engine is ready to be used

Speaking: The engine is currently running and talking back to the end users

Paused: The Player is paused.

BackendError:  There is a error with one of the backends that you want to use

Default:  Before anything happens there is a Default state that is used

 */
TextToSpeech::State TextToSpeech::state()
{
    return m_state;
}
/*!
\qmlproperty string TextToSpeech::text

The text that is going to be read to the end user.

Example:

\code
TextToSpeech{
    text: "What I want the voice to say"
}
\endcode

*/
QString TextToSpeech::text()
{
    return m_text;
}

void TextToSpeech::setText(const QString &text)
{
    if(m_text == text)
        return;
    m_text = text;
    emit textChanged();
}

/*!
 \qmlproperty int TextToSpeech::pitch

 Setthe pitch of the voice.
*/
int TextToSpeech::pitch()
{
    return m_pitch;
}

void TextToSpeech::setPitch(int &pitch)
{
    if(m_pitch == pitch)
        return;
    m_pitch = pitch;
    emit pitchChanged();
}

/*!
\qmlproperty int TextToSpeech::rate
 Set how fast the voice will talk back to the enduser.
 */
int TextToSpeech::rate()
{
    return m_rate;
}

void TextToSpeech::setRate(int &rate)
{
    if(m_rate == rate)
        return;

    m_rate = rate;
    emit rateChanged();

//    if(m_speech->Speaking){
//        qDebug() << "You should stop the tts and try again";

//    }else{
//        m_speech->setRate(m_rate / 10.0);
//    }
}

void TextToSpeech::setLanguage(const int &language)
{
    if(m_language == language)
        return;
    m_language = language;
    emit languageChanged();
}

/*!
\qmlproperty int TextToSpeech::voice

set the voice that the engine should be using.
 */
int TextToSpeech::voice()
{
    return m_voice;
}

void TextToSpeech::setVoice(const int &voice)
{
    if(m_voice == voice)
        return;
    m_voice = voice;
    emit voiceChanged();
}

//int TextToSpeech::volume()
//{
//    return m_volume;
//}

//void TextToSpeech::setVolume(const int &volume)
//{
//    if(m_volume == volume)
//        return;
//    m_volume = volume;
//    emit volumeChanged();
//}


/*!
 * \qmlproperty int  TextToSpeech::language
 Set the language that the engine will be using.

 \b{See Also} getLangues()
 */
int TextToSpeech::language()
{
    return m_language;
}

/*!
 \qmlmethod void TextToSpeech::stop

Stop the engine from talking.

\b{See Also} pause() start()
*/
void TextToSpeech::stop()
{
    m_speech->stop();
}

/*!
 \qmlmethod  void TextToSpeech::pause
 Pause the player that is talking.
 */
void TextToSpeech::pause()
{
    m_speech->pause();
}
/*!
\qmlmethod void TextToSpeech::resume()
used aresume the player after it has been paused
 */
void TextToSpeech::resume()
{
    m_speech->resume();
}


void TextToSpeech::handelStateChange(QTextToSpeech::State state)
{
    qDebug() << "State has changed !!" ;
    if (mm_state == state){
        return;
    }else{
        switch (mm_state) {
        case QTextToSpeech::Ready:
            m_state = Ready;
            break;
        case QTextToSpeech::Speaking:
            m_state = Speaking ;
            break;
        case QTextToSpeech::Paused:
            m_state = Paused;
            break;
        case QTextToSpeech::BackendError:
            m_state = BackendError;
            break;

        }
        emit stateChanged();
    }
}
void TextToSpeech::setupEngines()
{
    m_engines.clear();
    m_engines << "Default";
    foreach (QString engine, QTextToSpeech::availableEngines()){
       m_engines << engine;
    }
}

/*!
 * \brief TextToSpeech::setupVoices
 */
void TextToSpeech::setupVoices()
{
    m_voices.clear();
    m_vs = m_speech->availableVoices();

//    qDebug() << m_vs;
//    QVoice currentVoice = m_speech->voice();
    foreach (const QVoice &voice, m_vs) {
        m_voices << QString("%1 - %2 - %3")
                    .arg(voice.name())
                    .arg(QVoice::genderName(voice.gender()))
                    .arg(QVoice::ageName(voice.age()));

//        if (voice.name() == currentVoice.name())
//            ui.voice->setCurrentIndex(ui.voice->count() - 1);
    }
}


/*!
 * \qmlproperty stringlist TextToSpeech::languages
returns a array list of all the languages that are present in the engine,
 */
QStringList TextToSpeech::languages()
{
    return m_languages;
}
void TextToSpeech::setupLanguages()
{
    m_languages.clear();

//    m_locales = m_speech->availableLocales();
    QVector<QLocale> locales = m_speech->availableLocales();
//    QLocale current = m_speech->locale();
    foreach (const QLocale &locale, locales) {
//        QVariant localeVariant(locale);
        m_languages << QLocale::languageToString(locale.language());
//                     , localeVariant);
//        if (locale.name() == current.name())
//            current = locale;
    }

}

/*!
\qmlproperty stringlist TextToSpeech::voices
   returns a list of all the voices that are supported but the engine.
*/
QStringList TextToSpeech::voices()
{
 return m_voices;
}

/*!
 \qmlproperty stringlist TextToSpeech::engines
returns a string list of all the available engines that are available to use.
 */
QStringList TextToSpeech::engines()
{
    return m_engines;
}


/*!
 * \qmlmethod TextToSpeech::speak()

 This runs the engine.
 */
void TextToSpeech::speak()
{
     qDebug() << "before start " << m_speech->state();
    if(m_text.isEmpty()){
        qDebug() << "There is no text to read";
        m_speech->stop();
    }else{

        delete m_speech;
        m_speech = new QTextToSpeech(this);

        m_speech->setRate(m_rate / 10.0);
        m_speech->setPitch(m_pitch / 10.0);
        // For some reason this crashes the applications
//        m_speech->setVolume(m_volume);
        m_speech->say(m_text);
        qDebug() << "after start " << m_speech->state();
        m_speech->deleteLater();
    }
}
