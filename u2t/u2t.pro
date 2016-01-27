TEMPLATE = app
QT += qml \
      quick

SOURCES += \
        $$PWD/shell/src/main.cpp \
        shell/src/iconprovider.cpp

HEADERS += \
    shell/src/iconprovider.h

RESOURCES += \
            $$PWD/shell/qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

