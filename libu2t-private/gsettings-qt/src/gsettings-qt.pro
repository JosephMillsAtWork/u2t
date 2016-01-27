TEMPLATE = lib
INCLUDEPATH += .
QT -= gui

CONFIG += qt no_keywords link_pkgconfig create_pc create_prl no_install_prl c++11
PKGCONFIG += gio-2.0

TARGET = gsettings-qt

HEADERS = qgsettings.h \
          util.h \
          qconftypes.h

SOURCES = qgsettings.cpp \
          util.cpp \
          qconftypes.cpp

target.path = $$[QT_INSTALL_LIBS]
INSTALLS += target

headers.path = $$[QT_INSTALL_HEADERS]/QGSettings
headers.files = qgsettings.h QGSettings
INSTALLS += headers

QMAKE_PKGCONFIG_NAME = GSettingsQt
QMAKE_PKGCONFIG_DESCRIPTION = Qt bindings to GSettings
QMAKE_PKGCONFIG_PREFIX = $$INSTALLBASE
QMAKE_PKGCONFIG_LIBDIR = $$target.path
QMAKE_PKGCONFIG_INCDIR = $$headers.path
QMAKE_PKGCONFIG_VERSION = $$VERSION
QMAKE_PKGCONFIG_DESTDIR = pkgconfig
