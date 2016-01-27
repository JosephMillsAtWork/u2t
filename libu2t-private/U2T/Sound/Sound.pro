TEMPLATE = lib
TARGET = U2T.Sound
QT += qml quick dbus network core
CONFIG += link_pkgconfig c++11 qt plugin

PKGCONFIG += alsa \
            libpulse \
            libpulse-mainloop-glib

TARGET = $$qtLibraryTarget($$TARGET)
uri = U2T.Sound

HEADERS += \
    alsamixer.h \
    pulseaudiomixer.h \
    sound.h \
    sound_plugin.h

SOURCES += \
    alsamixer.cpp \
    pulseaudiomixer.cpp \
    sound.cpp \
    sound_plugin.cpp

OTHER_FILES =  \
   qmldir

!equals(_PRO_FILE_PWD_, $$OUT_PWD) {
    copy_qmldir.target = $$OUT_PWD/qmldir
    copy_qmldir.depends = $$_PRO_FILE_PWD_/qmldir
    copy_qmldir.commands = $(COPY_FILE) \"$$replace(copy_qmldir.depends, /, $$QMAKE_DIR_SEP)\" \"$$replace(copy_qmldir.target, /, $$QMAKE_DIR_SEP)\"
    QMAKE_EXTRA_TARGETS += copy_qmldir
    PRE_TARGETDEPS += $$copy_qmldir.target
}

qmldir.files = qmldir
installPath = $$[QT_INSTALL_QML]/$$replace(uri, \\., /)
qmldir.path = $$installPath
target.path = $$installPath
INSTALLS += target qmldir

qmltypes.extra = $$[QT_INSTALL_BINS]/qmlplugindump -notrelocatable U2T.Sound 1.0 .. > $(INSTALL_ROOT)/$$installPath/plugins.qmltypes


