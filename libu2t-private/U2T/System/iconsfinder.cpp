#include "iconsfinder.h"


IconsFinder::IconsFinder(QObject *parent) : QObject(parent)
{
    // INIT the getters
    initIconClass();
    connect(this,SIGNAL(initIconTheme(QStringList)),this,SLOT(setIconThemeList(QStringList)));
    connect(this,SIGNAL(initCursorTheme(QStringList)),this,SLOT(setCursorThemeList(QStringList)));


}

QStringList IconsFinder::iconThemeList() const
{
    return m_iconThemeList;
}

void IconsFinder::initIconClass()
{
   QStringList possibleDirs;
   possibleDirs << "/usr/share/gnome/icons" << "/usr/local/share/icons" << "/usr/share/icons" ;
   QIcon icon ;
   icon.setThemeSearchPaths(possibleDirs);
   QStringList baseDirs = icon.themeSearchPaths();
   QStringList fList;
   QStringList cusorList ;
   foreach (QString baseDirName, baseDirs)
   {
       QDir baseDir(baseDirName);
       //        qDebug() << "QDIR BASENAME " << baseDir << "\n";
       if (!baseDir.exists())
           continue;
       QFileInfoList dirs = baseDir.entryInfoList(QDir::AllDirs | QDir::NoDotAndDotDot, QDir::Name);
       foreach (QFileInfo dir, dirs)
       {

           // look at the dirs and see if there is icon sets.
           QString cusorChecker = QString("%1/%2").arg(dir.canonicalFilePath()).arg("cursors");
           QString fileName = QString("%1/%2").arg(dir.canonicalFilePath()).arg("index.theme");

           // Check to see if there is a icon Theme
           QFile file(fileName);
           if(file.open(QFile::ReadOnly | QFile::Text)){
               QTextStream in(&file);
               while (!in.atEnd()) {
                   QString line = in.readLine();
                   //qDebug() << line ;
                   if (line.contains("48x48")){
                       fList << dir.canonicalFilePath();
                   }
               }
               }
               else{
                   qDebug() << "could npot open file fpor reading ";
               }
               file.close();

           // Check to see if there is a cursors Theme
           QDir cuDir(cusorChecker);
           if(cuDir.exists()){
               cusorList << dir.canonicalFilePath();
           }
       }
   }
   fList.removeDuplicates();
   cusorList.removeDuplicates();
   setIconThemeList(fList) ;
   setCursorThemeList(cusorList);
}

QStringList IconsFinder::cursorList() const
{
    return m_cursorThemeList;
}

QString IconsFinder::currentIcon() const
{

    return QIcon::themeName();
//    return m_currentIcon;
}

void IconsFinder::setCurrentIcon(const QString iconTheme)
{
    QIcon::setThemeName(iconTheme);
}


void IconsFinder::setIconThemeList(const QStringList iconThemeList)
{
    if(m_iconThemeList == iconThemeList)
        return;
    m_iconThemeList = iconThemeList;
    emit iconThemeListChanged();
}

void IconsFinder::setCursorThemeList(const QStringList cursorThemeList)
{
    if(m_cursorThemeList == cursorThemeList)
        return;
    m_cursorThemeList = cursorThemeList;
    emit cursorListChanged();
}

