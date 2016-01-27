#ifndef INDICATORS_H
#define INDICATORS_H

#include <QQuickItem>

class Indicators : public QQuickItem
{
    Q_OBJECT
    Q_DISABLE_COPY(Indicators)

public:
    Indicators(QQuickItem *parent = 0);
    ~Indicators();
};

#endif // INDICATORS_H

