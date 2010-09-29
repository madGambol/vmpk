/*
    MIDI Virtual Piano Keyboard
    Copyright (C) 2008-2010, Pedro Lopez-Cabanillas <plcl@users.sf.net>

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License along
    with this program; If not, see <http://www.gnu.org/licenses/>.
*/

#include "constants.h"
#include "vpiano.h"
#include "rawkeybdapp.h"
#include <QtGui/QApplication>

int main(int argc, char *argv[])
{
    QCoreApplication::setOrganizationName(QSTR_DOMAIN);
    QCoreApplication::setOrganizationDomain(QSTR_DOMAIN);
    QCoreApplication::setApplicationName(QSTR_APPNAME);
    RawKeybdApp a(argc, argv);
#ifdef Q_OS_LINUX
    a.setWindowIcon(QIcon(":/vpiano/vmpk_32x32"));
#endif //Q_OS_LINUX
    VPiano w;
    if (w.isInitialized()) {
        w.show();
        return a.exec();
    }
    return EXIT_FAILURE;
}
