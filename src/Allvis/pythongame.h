#ifndef GAME_H
#define GAME_H

#include <QObject>
#include <QProcess>
#include <QCoreApplication>

// Class used to tun the script
class PythonGame : public QObject
{
    Q_OBJECT
public:
    Q_INVOKABLE int run_game();
signals:

public slots:
};

#endif // GAME_H
