#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <pythongame.h>
#include <QtWebEngine>

int main(int argc, char *argv[])
{   //
    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    qmlRegisterType<PythonGame>("com.PythonGame",1,0,"PythonGame"); // Imports the c++ code so that it can be used as a QML-element
    QtWebEngine::initialize();  // Initializing QtWebEngine so that the web browser is enabled

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
