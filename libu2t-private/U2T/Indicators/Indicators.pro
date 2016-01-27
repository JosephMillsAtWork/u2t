TEMPLATE = lib
TARGET = U2T.Indicators
QT += qml quick core network multimedia texttospeech
CONFIG += qt plugin c++11

TARGET = $$qtLibraryTarget($$TARGET)
uri = U2T.Indicators

DISTFILES = \
    Indicators/SettingsIndicator.qml \
    Indicators/PowerIndicator.qml \
    Indicators/NetworkIndicator.qml \
    Indicators/KeyboardIndicator.qml \
    Indicators/CalenderIndicator.qml \
    Indicators/BatteryIndicator.qml \
    Indicators/IndicatorButton.qml \
    Indicators/SoundIndicator.qml \
    Indicators/SpeechToTextIndicator.qml

OTHER_FILES += \
            qmldir

qml.files += $${DISTFILES}
qml.path = $$[QT_INSTALL_QML]/$$replace(uri, \\., /)


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




INSTALLS += target qmldir qml


qmltypes.extra = $$[QT_INSTALL_BINS]/qmlplugindump -notrelocatable U2T.Indicators 1.0 .. > $(INSTALL_ROOT)/$$installPath/plugins.qmltypes

