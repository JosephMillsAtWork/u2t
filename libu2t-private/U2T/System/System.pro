TEMPLATE = lib
TARGET = U2T.System
QT += qml quick dbus core KConfigCore
CONFIG += c++11 plugin qt
TARGET = $$qtLibraryTarget($$TARGET)
uri = U2T.System

INCLUDEPATH += /usr/include/KF5

HEADERS += \
    qmlprocess.h \
    system_plugin.h \
    iconprovider.h \
    keyeventfilter.h \
    kquickconfig.h \
    sortfilterproxymodel.h \
    iconsfinder.h

SOURCES += \
    qmlprocess.cpp \
    system_plugin.cpp \
    iconprovider.cpp \
    keyeventfilter.cpp \
    kquickconfig.cpp \
    sortfilterproxymodel.cpp \
    iconsfinder.cpp

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

qmltypes.extra = $$[QT_INSTALL_BINS]/qmlplugindump -notrelocatable U2T.System 1.0 .. > $(INSTALL_ROOT)/$$installPath/plugins.qmltypes

