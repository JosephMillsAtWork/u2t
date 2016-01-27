#include "indicators_plugin.h"
#include "indicators.h"

#include <qqml.h>

void IndicatorsPlugin::registerTypes(const char *uri)
{
    // @uri Ut2.Indicators
    qmlRegisterType<Indicators>(uri, 1, 0, "Indicators");
}


