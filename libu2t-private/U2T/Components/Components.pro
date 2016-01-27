TEMPLATE = lib
TARGET = U2T.Components
QT += qml quick
CONFIG += c++11 plugin qt
TARGET = $$qtLibraryTarget($$TARGET)
uri = U2T.Components

HEADERS += \
    components_plugin.h

SOURCES += \
    components_plugin.cpp


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

qmltypes.extra = $$[QT_INSTALL_BINS]/qmlplugindump -notrelocatable U2T.Components 1.0 .. > $(INSTALL_ROOT)/$$installPath/plugins.qmltypes

DISTFILES += \
    IconButton.qml \
    Popover.qml \
    PopupBase.qml \
    ToolTip.qml \
    TTSHelper.qml \
    U2TObject.qml

deployment.files += \
            $${DISTFILES}



deployment.path = $$[QT_INSTALL_QML]/U2T/Components
INSTALLS += deployment



