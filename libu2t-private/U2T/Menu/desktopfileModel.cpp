/*
 * Copyright (C) 2014 Joseph Mills.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
#include "desktopfileModel.h"

DFile::DFile(
            const QString &name,
            const QString &comment,
            const QString &exec,
            const QString &type,
            bool &terminal,
            const QString &icon
        ):
      m_name(name),
      m_comment(comment),
      m_exec(exec),
      m_type(type),
      m_terminal(terminal),
      m_icon(icon)
{
}

QString DFile::name() const
{
    return m_name;
}

QString DFile::comment() const
{
    return m_comment;
}
QString DFile::exec() const
{
    return m_exec;
}
QString DFile::type() const
{
    return m_type;
}

bool DFile::terminal() const
{
    return m_terminal;
}
QString DFile::icon() const
{
    return m_icon;
}

AllDesktopFileModel::AllDesktopFileModel(QObject *parent)
    : QAbstractListModel(parent)
{
}

void AllDesktopFileModel::addDesktopFile(const DFile &desktopFile)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_desktopFiles << desktopFile;
    endInsertRows();
}

int AllDesktopFileModel::rowCount(const QModelIndex &) const {
    return m_desktopFiles.count();
}

QVariant AllDesktopFileModel::data(const QModelIndex & index, int role) const {
    if (index.row() < 0 || index.row() > m_desktopFiles.count())
        return QVariant();
    const DFile &desktopFile = m_desktopFiles[index.row()];
    if (role == NameRole)
        return desktopFile.name();
    else if (role == CommentRole)
        return desktopFile.comment();
    else if (role == ExecRole)
        return desktopFile.exec();
    else if (role == TypeRole)
        return desktopFile.type();
    else if (role == TerminalRole)
        return desktopFile.terminal();
    else if (role == IconRole)
        return desktopFile.icon();
    return QVariant();
}

QHash<int, QByteArray> AllDesktopFileModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[NameRole] = "name";
    roles[CommentRole] = "comment";
    roles[ExecRole] = "exec";
    roles[TypeRole] = "type";
    roles[TerminalRole] = "terminal";
    roles[IconRole] = "icon";
    return roles;
}
