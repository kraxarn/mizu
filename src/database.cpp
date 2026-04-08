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

auto Database::insertDrinkType() const -> bool
{
	const QMap<QString, QVariant> values = {
		{QStringLiteral(":icon"), QStringLiteral("glass-water")},
		{QStringLiteral(":name"), QStringLiteral("Water")},
		{QStringLiteral(":impact"), 1.F},
	};

	return exec(QStringLiteral(":/sql/drink_types_insert.sql"), values);
}

auto Database::exec(const QString &path, const QMap<QString, QVariant> &values) const -> bool
{
	QFile file(path);
	if (!file.open(QIODevice::ReadOnly))
	{
		qWarning() << "Failed to open query:" << file.errorString();
		return false;
	}

	const QString content = QString::fromUtf8(file.readAll());
	file.close();

	QSqlQuery query(mDb);

	if (!query.prepare(content))
	{
		qWarning() << "Failed to prepare query:" << query.lastError().text();
		return false;
	}

	QMapIterator iter(values);
	while (iter.hasNext())
	{
		iter.next();
		query.bindValue(iter.key(), iter.value());
	}

	if (!query.exec())
	{
		qWarning() << "Failed to execute query:" << query.lastError().text();
		return false;
	}

	return true;
}

auto Database::initDb() const -> bool
{
	return exec(QStringLiteral(":/sql/drink_types_create.sql"))
		&& exec(QStringLiteral(":/sql/presets_create.sql"));
}
