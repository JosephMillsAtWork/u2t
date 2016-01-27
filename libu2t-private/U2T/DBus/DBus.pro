TEMPLATE = lib
TARGET = U2T.DBus
QT += dbus qml
QT -= gui
CONFIG += qt plugin hide_symbols c++11
uri = U2T.DBus

SOURCES += \
    plugin.cpp \
    declarativedbus.cpp \
    declarativedbusadaptor.cpp \
    declarativedbusinterface.cpp

HEADERS += \
    declarativedbus.h \
    declarativedbusadaptor.h \
    declarativedbusinterface.h

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

qmltypes.extra = $$[QT_INSTALL_BINS]/qmlplugindump -notrelocatable U2T.DBus 1.0 .. > $(INSTALL_ROOT)/$$installPath/plugins.qmltypes

