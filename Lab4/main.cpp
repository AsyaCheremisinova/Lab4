#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "starlist.h"
#include <QQmlContext>
#include <QtSql>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    QQmlContext *context = engine.rootContext();

    StarList viewModel(&app);
    context->setContextObject(&viewModel);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
