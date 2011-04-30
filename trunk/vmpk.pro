# Virtual MIDI Piano Keyboard
# Copyright (C) 2008-2011 Pedro Lopez-Cabanillas <plcl@users.sourceforge.net>
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
# You should have received a copy of the GNU General Public License along
# with this program; If not, see <http://www.gnu.org/licenses/>.
TEMPLATE = app
TARGET = vmpk
VERSION = 0.4.0
QT += core \
    gui \
    xml \
    svg
contains(DEFINES, ENABLE_DBUS) {
    CONFIG += qdbus
    DBUS_ADAPTORS += src/net.sourceforge.vmpk.xml
}
contains(QT_VERSION, ^4\\.[0-5]\\..*) {
    message("Cannot build VMPK with Qt $${QT_VERSION}")
    error("Use at least Qt 4.6")
}
VERSIONH = $$sprintf(const QString PGM_VERSION(\"%1\");,$$VERSION)
win32 {
    system(echo $$VERSIONH > $$OUT_PWD/vmpk_version.h)
}
else {
    system(echo \'$$VERSIONH\' > $$OUT_PWD/vmpk_version.h)
}
simulator|symbian {
    DEFINES += NETWORK_MIDI
    DEFINES += SMALL_SCREEN
}
symbian {
    LIBS += -lcone -leikcore -lavkon
    ICON = data/vmpk.svg
}
win32:!simulator {
    DEFINES += __WINDOWS_MM__
    DEFINES += RAWKBD_SUPPORT
    LIBS += -lwinmm
    RC_FILE = src/vpianoico.rc
}
linux*:!simulator {
    DEFINES += __LINUX_ALSASEQ__
    DEFINES += AVOID_TIMESTAMPING
    DEFINES += RAWKBD_SUPPORT
    CONFIG += link_pkgconfig x11
    PKGCONFIG += alsa
    LIBS += -lpthread
}
macx { 
    CONFIG += x86 \
        ppc
    ICON = data/vmpk.icns
    DEFINES += __MACOSX_CORE__
    DEFINES += RAWKBD_SUPPORT
    BUNDLE_RES.files = data/help.html \
        data/help_de.html \
        data/help_es.html \
        data/help_fr.html \
        data/help_nl.html \
        data/help_ru.html \
        data/gmgsxg.ins \
        data/spanish.xml \
        data/german.xml \
        data/azerty.xml \
        data/it-qwerty.xml \
        data/vkeybd-default.xml \
        data/pc102mac.xml \
        qt.conf \
        $$[QT_INSTALL_TRANSLATIONS]/qt_cs.qm \
        $$[QT_INSTALL_TRANSLATIONS]/qt_de.qm \
        $$[QT_INSTALL_TRANSLATIONS]/qt_es.qm \
        $$[QT_INSTALL_TRANSLATIONS]/qt_fr.qm \
        $$[QT_INSTALL_TRANSLATIONS]/qt_ru.qm \
        $$[QT_INSTALL_TRANSLATIONS]/qt_zh_CN.qm \
        $$OUT_PWD/vmpk_cs.qm \
        $$OUT_PWD/vmpk_de.qm \
        $$OUT_PWD/vmpk_es.qm \
        $$OUT_PWD/vmpk_fr.qm \
        $$OUT_PWD/vmpk_nl.qm \
        $$OUT_PWD/vmpk_ru.qm \
        $$OUT_PWD/vmpk_sv.qm \
        $$OUT_PWD/vmpk_zh_CN.qm
    BUNDLE_RES.path = Contents/Resources
    QMAKE_BUNDLE_DATA += BUNDLE_RES
    LIBS += -framework \
        CoreMidi \
        -framework \
        CoreAudio \
        -framework \
        CoreFoundation \
        -framework \
        Carbon
}
irix* { 
    CONFIG += x11
    DEFINES += __IRIX_MD__
    DEFINES += RAWKBD_SUPPORT
    LIBS += -laudio \
        -lpthread
}
debug:DEFINES += __RTMIDI_DEBUG__
INCLUDEPATH += src

# Input
FORMS += src/about.ui \
    src/extracontrols.ui \
    src/kmapdialog.ui \
    src/midisetup.ui \
    src/preferences.ui \
    src/riffimportdlg.ui \
    src/shortcutdialog.ui \
    src/vpiano.ui

HEADERS += src/about.h \
    src/classicstyle.h \
    src/constants.h \
    src/events.h \
    src/extracontrols.h \
    src/instrument.h \
    src/keyboardmap.h \
    src/keylabel.h \
    src/kmapdialog.h \
    src/knob.h \
    src/mididefs.h \
    src/midisetup.h \
    src/pianodefs.h \
    src/pianokeybd.h \
    src/pianokey.h \
    src/pianoscene.h \
    src/preferences.h \
    src/qticonloader.h \
    src/rawkeybdapp.h \
    src/riff.h \
    src/riffimportdlg.h \
    src/RtError.h \
    src/RtMidi.h \
    src/shortcutdialog.h \
    src/vpiano.h
    
SOURCES += src/about.cpp \
    src/classicstyle.cpp \
    src/extracontrols.cpp \
    src/instrument.cpp \
    src/keyboardmap.cpp \
    src/keylabel.cpp \
    src/kmapdialog.cpp \
    src/knob.cpp \
    src/main.cpp \
    src/midisetup.cpp \
    src/pianokeybd.cpp \
    src/pianokey.cpp \
    src/pianoscene.cpp \
    src/preferences.cpp \
    src/qticonloader.cpp \
    src/rawkeybdapp.cpp \
    src/riff.cpp \
    src/riffimportdlg.cpp \
    src/RtMidi.cpp \
    src/udpmidi.cpp \
    src/shortcutdialog.cpp \
    src/vpiano.cpp

RESOURCES += data/vmpk.qrc

TRANSLATIONS +=  translations/vmpk_cs.ts \
    translations/vmpk_de.ts \
    translations/vmpk_es.ts \
    translations/vmpk_fr.ts \
    translations/vmpk_nl.ts \
    translations/vmpk_ru.ts \
    translations/vmpk_sv.ts \
    translations/vmpk_zh_CN.ts

include(updateqm.pri)
