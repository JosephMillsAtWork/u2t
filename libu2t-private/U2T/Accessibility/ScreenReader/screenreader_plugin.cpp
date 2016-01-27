#include "screenreader_plugin.h"
#include <qqml.h>

// local
#include "texttospeech.h"

void Libu2t_PrivatePlugin::registerTypes(const char *uri)
{
    // @uri U2T.Accessibility.ScreenReader
    qmlRegisterType<TextToSpeech>(uri, 1, 0, "TextToSpeech");
}
