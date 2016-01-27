TEMPLATE += aux

DISTFILES += \
    metadata.desktop \
    theme.conf \
    IndicatorRow.qml \
    KeyboardIndicator.qml \
    Main.qml \
    PowerIndicator.qml \
    SessionIndicator.qml \
    UserDelegate.qml \
    images/wallpaper.png \
    images/reload.svg \
    images/sleep.svg

sddm.files += \
    metadata.desktop \
    theme.conf \
    IndicatorRow.qml \
    KeyboardIndicator.qml \
    Main.qml \
    PowerIndicator.qml \
    SessionIndicator.qml \
    UserDelegate.qml \
    images/wallpaper.png \
    images/reload.svg \
    images/sleep.svg

sddm.path = /usr/share/sddm/themes/u2t/
INSTALLS +=  sddm

