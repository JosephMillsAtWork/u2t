TEMPLATE = subdirs
CONFIG += ordered 
SUBDIRS += \
           libu2t-private \
           session

OTHER_FILES += \
            data/com.iheartqt.U2T.gschema.xml \
            data/u2t.desktop \
            data/u2t-wayland.desktop

desktop.files += \
            data/u2t.desktop
desktop.path = /usr/share/applications/


wayland.files += \
            data/u2t-wayland.desktop
wayland.path =  /usr/share/wayland-sessions


gschema.files += \
            data/com.iheartqt.U2T.gschema.xml
gschema.path = /usr/share/glib-2.0/schemas/



INSTALLS += gschema wayland desktop


schema.commands = glib-compile-schemas /usr/share/glib-2.0/schemas/
QMAKE_EXTRA_TARGETS += schema
POST_TARGETDEPS += schema
