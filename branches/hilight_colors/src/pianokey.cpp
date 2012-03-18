/*
    Virtual Piano Widget for Qt4 
    Copyright (C) 2008-2012, Pedro Lopez-Cabanillas <plcl@users.sf.net>

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

#include "pianokey.h"
#include <QtGui/QApplication>
#include <QtGui/QPainter>
#include <QtGui/QPalette>
#include <QtSvg/QSvgRenderer>

PianoKey::PianoKey(const QRectF &rect, const QColor &color, const int note)
    : QGraphicsRectItem(rect),
    m_pressed(false),
    m_note(note),
    m_black(false)
{
    if (color.isValid())
        m_color = color;
    setAcceptedMouseButtons(Qt::NoButton);
}

PianoKey::PianoKey(const QRectF &rect, const bool black, const int note)
    : QGraphicsRectItem(rect),
    m_pressed(false),
    m_note(note),
    m_black(black)
{
    m_color = (black) ? QColor(Qt::black) : QColor(Qt::white);
    setAcceptedMouseButtons(Qt::NoButton);
}

void PianoKey::paint(QPainter *painter, const QStyleOptionGraphicsItem *, QWidget *)
{
    static QSvgRenderer keyRenderer(QString(":/vpiano/blkey.svg"));
    static const QPen blackPen(Qt::black, 1);
    static const QPen grayPen(QBrush(Qt::gray), 1, Qt::SolidLine,  Qt::RoundCap, Qt::RoundJoin);
    QBrush tmpBrush;
    QColor tmpColor;
    if (m_pressed) {
        tmpColor = m_pressedColor;
    } else {
        tmpColor = m_color;
    }

    tmpBrush = QBrush(tmpColor);
    painter->setBrush(tmpBrush);
    painter->setPen(blackPen);
    painter->drawRoundRect(rect(), 15, 15);
    if (m_black)
        keyRenderer.render(painter, rect());
    else {
        QPointF points[3] = {
             QPointF(rect().left()+1.5, rect().bottom()-1),
             QPointF(rect().right()-1, rect().bottom()-1),
             QPointF(rect().right()-1, rect().top()+1),
        };
        painter->setPen(grayPen);
        painter->drawPolyline(points, 3);
    }
}

void PianoKey::setPressed(bool p)
{
    if (p != m_pressed) {
        m_pressed = p;
        update();
    }
}

void PianoKey::setPressedColor(const QColor& c)
{
    if (c.isValid()) {
        m_pressedColor = c;
    }
}
