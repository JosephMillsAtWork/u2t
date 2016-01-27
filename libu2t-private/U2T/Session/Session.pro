TEMPLATE = lib
TARGET = U2T.Session
QT += qml quick dbus network core
CONFIG += c++11 qt plugin link_pkgconfig
PKGCONFIG += pm-utils
TARGET = $$qtLibraryTarget($$TARGET)

uri = U2T.Session




SOURCES += \
    session_plugin.cpp \
    sessionmanager.cpp

HEADERS += \
    session_plugin.h \
    sessionmanager.h

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

qmltypes.extra = $$[QT_INSTALL_BINS]/qmlplugindump -notrelocatable U2T.Session 1.0 .. > $(INSTALL_ROOT)/$$installPath/plugins.qmltypes


