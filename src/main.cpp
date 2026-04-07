#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickStyle>

#include "database.hpp"
#include "settings.hpp"

#define registerType(t) qmlRegisterType<t>(#t,1,0,#t)

namespace
{
	void defineTypes(const QQmlApplicationEngine &engine)
	{
		engine.rootContext()->setContextProperty(QStringLiteral("AppName"),
			QCoreApplication::applicationName());

		engine.rootContext()->setContextProperty(QStringLiteral("AppVersion"),
			QCoreApplication::applicationVersion());

		engine.rootContext()->setContextProperty(QStringLiteral("QtVersion"),
			QStringLiteral(QT_VERSION_STR));

		engine.rootContext()->setContextProperty(QStringLiteral("BuildDate"),
			QStringLiteral(__DATE__));

		registerType(Settings);
		registerType(Database);
	}
}

auto main(int argc, char **argv) -> int
{
	QCoreApplication::setApplicationName(QStringLiteral(APP_NAME));
	QCoreApplication::setApplicationVersion(QStringLiteral(APP_VERSION));
	QCoreApplication::setOrganizationName(QStringLiteral(ORG_NAME));
	QCoreApplication::setOrganizationDomain(QStringLiteral(ORG_DOMAIN));

	const QGuiApplication app(argc, argv);

	QQmlApplicationEngine engine;
	defineTypes(engine);

	// TODO: For now at least, mostly designed as a mobile app anyway
	QQuickStyle::setStyle(QStringLiteral("Material"));

	QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
		&app, [](const QUrl &url) -> void
		{
			qCritical() << "Failed to load:" << url.toString();
			QCoreApplication::exit(-1);
		}, Qt::QueuedConnection);

	engine.load(QStringLiteral(":/qml/Main.qml"));

	return QCoreApplication::exec();
}
