#include "sound_plugin.h"
#include <qqml.h>

// local
#include "sound.h"

void Libu2t_PrivatePlugin::registerTypes(const char *uri)
{
    // @uri U2T.Sound
    qmlRegisterType<Sound>(uri, 1, 0, "Sound");
}



