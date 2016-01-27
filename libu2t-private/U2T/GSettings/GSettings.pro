TEMPLATE = lib
QT += qml quick
QT -= gui

CONFIG += qt plugin \
	  no_keywords \
          link_pkgconfig \
          c++11

PKGCONFIG += gio-2.0

INCLUDEPATH += ../../gsettings-qt/src .
LIBS += -L../../gsettings-qt/src -lgsettings-qt

TARGET = U2T.GSettings

HEADERS = plugin.h \
          gsettings-qml.h
SOURCES = plugin.cpp \
          gsettings-qml.cpp

uri = U2T.GSettings

# deployment rules for the plugin
installPath = $$[QT_INSTALL_QML]/$$replace(uri, \\., /)
target.path = $$installPath
INSTALLS += target

extra.path = $$installPath
extra.files += qmldir
INSTALLS += extra

qmltypes.path = $$installPath
qmltypes.files = plugins.qmltypes
qmltypes.extra = export LD_PRELOAD=../src/libgsettings-qt.so.1; $$[QT_INSTALL_BINS]/qmlplugindump -notrelocatable U2T.GSettings 1.0 .. > $(INSTALL_ROOT)/$$installPath/plugins.qmltypes
INSTALLS += qmltypes

