TEMPLATE = lib
QT += qml quick core dbus network
QT += Solid KConfigCore KConfigGui KDeclarative NetworkManagerQt ModemManagerQt
CONFIG += qt plugin link_pkgconfig c++11 no_keywords
PKGCONFIG += libnm \
             ModemManager \
             NetworkManager

TARGET = U2T.Networking
uri = U2T.Networking

INCLUDEPATH += "/usr/include/KF5/NetworkManagerQt"


SOURCES += \
    appletproxymodel.cpp \
    availabledevices.cpp \
    connectionicon.cpp \
    debug.cpp \
    enabledconnections.cpp \
    enums.cpp \
    handler.cpp \
    networkitemslist.cpp \
    networkmodel.cpp \
    networkmodelitem.cpp \
    networkstatus.cpp \
    networking_plugin.cpp \
    uiutils.cpp

HEADERS += \
    appletproxymodel.h \
    availabledevices.h \
    connectionicon.h \
    debug.h \
    enabledconnections.h \
    enums.h \
    handler.h \
    networkitemslist.h \
    networkmodel.h \
    networkmodelitem.h \
    networkstatus.h \
    networking_plugin.h \
    uiutils.h

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

qmltypes.extra = $$[QT_INSTALL_BINS]/qmlplugindump -notrelocatable U2T.Networking 1.0 .. > $(INSTALL_ROOT)/$$installPath/plugins.qmltypes
