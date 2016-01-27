TEMPLATE = lib
TARGET = U2T.Windowing
QT += qml quick
CONFIG += c++11 qt plugin
TARGET = $$qtLibraryTarget($$TARGET)
uri = U2T.Windowing

OTHER_FILES =  \
    qmldir \
    PopupWindow.qml \
    TopLevelWindow.qml \
    TransientWindow.qml \
    WindowAnimation.qml \
    WindowListModel.qml \
    WindowManager.qml \
    WindowPreview.qml \
    WindowWrapper.qml \
    Workspace.qml \
    WorkspaceEffect.qml


qml.files += PopupWindow.qml \
    TopLevelWindow.qml \
    TransientWindow.qml \
    WindowAnimation.qml \
    WindowListModel.qml \
    WindowManager.qml \
    WindowPreview.qml \
    WindowWrapper.qml \
    Workspace.qml \
    WorkspaceEffect.qml

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
qml.path = $$installPath
target.path = $$installPath
INSTALLS += target qmldir qml

qmltypes.extra = $$[QT_INSTALL_BINS]/qmlplugindump -notrelocatable U2T.Windowing 1.0 .. > $(INSTALL_ROOT)/$$installPath/plugins.qmltypes
