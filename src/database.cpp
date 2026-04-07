#include "database.hpp"

#include <QDir>
#include <QSqlError>
#include <QSqlQuery>
#include <QStandardPaths>

Database::Database(QObject *parent)
	: QObject(parent),
	mDb(QSqlDatabase::addDatabase(QStringLiteral("QSQLITE")))
{
	const QDir dir(QStandardPaths::writableLocation(QStandardPaths::AppConfigLocation));
	dir.mkpath(QStringLiteral("."));
	mDb.setDatabaseName(dir.filePath(QStringLiteral("config.db")));

	if (!mDb.open())
	{
		const QSqlError error = mDb.lastError();
		qWarning().nospace()
			<< "Failed to open database: " << error.text()
			<< " (" << error.type() << ")";

		return;
	}

	if (!initDb())
	{
		return;
	}
}

Database::~Database()
{
	mDb.close();
}

auto Database::initDb() const -> bool
{
	const std::array scripts = {
		QStringLiteral(":/sql/drink_types.sql"),
		QStringLiteral(":/sql/presets.sql"),
	};

	for (const QString &script: scripts)
	{
		QFile file(script);
		if (!file.open(QIODevice::ReadOnly))
		{
			qWarning() << "Failed to open init script:" << file.errorString();
			return false;
		}

		const QString content = QString::fromUtf8(file.readAll());
		file.close();

		if (QSqlQuery query(mDb); !query.exec(content))
		{
			qWarning() << "Failed to execute init script:" << query.lastError().text();
			return false;
		}
	}

	return true;
}
