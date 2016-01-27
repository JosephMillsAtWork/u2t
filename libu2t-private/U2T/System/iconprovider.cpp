#include "iconprovider.h"

#include <QIcon>
#include <QDebug>
IconProvider::IconProvider():
  QQuickImageProvider(QQuickImageProvider::Pixmap)
{
    QString theme = QIcon::themeName();

    qDebug() << "JOSEPH \n \n\n\n\n\n current extra theme is " << theme;
    QIcon::setThemeName(theme);
}
/*!

 */
QPixmap IconProvider::requestPixmap(const QString &id, QSize *realSize, const QSize &requestedSize)
{
    QIcon icon;
    Q_FOREACH (const QString &name, id.split(",", QString::SkipEmptyParts)) {
        icon = QIcon::fromTheme(name);
        if (!icon.isNull()) {
            if (requestedSize.isValid()) {
                *realSize =requestedSize;
                return icon.pixmap(requestedSize);
            } else {
                QList<QSize> sizes = icon.availableSizes();
                if (sizes.count() > 0 && sizes.last().isValid()) {
                    *realSize = sizes.last();
                } else {
                    *realSize = QSize(32,32);
                }
                return icon.pixmap(*realSize);
            }
            break;
        }
    }
    return  QPixmap();
}
