TEMPLATE = lib
TARGET = U2T.Menu
QT += qml quick dbus network core KConfigCore
CONFIG += c++11 qt plugin
TARGET = $$qtLibraryTarget($$TARGET)
uri = U2T.Menu

INCLUDEPATH += /usr/include/KF5/

LIBS += -L/usr/lib/x86_64-linux-gnu/ -lGreenIslandServer
LIBS += -L/usr/lib/x86_64-linux-gnu/ -lGreenIslandCompositor
LIBS += -L/usr/lib/x86_64-linux-gnu/ -lQt5Xdg


INCLUDEPATH += /usr/include/Hawaii/

# Input
SOURCES += \
        menu_plugin.cpp \
        launcheritem.cpp \
        mdesktopentry.cpp \
        mremoteaction.cpp \
        application.cpp \
        desktopfile.cpp \
        desktopfiles.cpp \
        launchermodel.cpp \
        qobjectlistmodel.cpp \
        desktopfileModel.cpp

HEADERS += \
        menu_plugin.h \
        launcheritem.h \
        mdesktopentry.h \
        mdesktopentry_p.h \
        mlite-global.h \
        mremoteaction.h \
        mremoteaction_p.h \
        application.h \
        desktopfile.h \
        desktopfiles.h \
        launchermodel.h \
        qobjectlistmodel.h \
        qquicklist.h \
        desktopfileModel.h



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


qmltypes.extra = $$[QT_INSTALL_BINS]/qmlplugindump -notrelocatable U2T.Menu 1.0 .. > $(INSTALL_ROOT)/$$installPath/plugins.qmltypes

