#pragma once

#include <QObject>
#include <qqmlintegration.h>
#include <QSqlDatabase>

class Database : public QObject
{
	Q_OBJECT
	QML_ELEMENT

public:
	explicit Database(QObject *parent = nullptr);

	~Database() override;

	[[nodiscard]]
	auto exec(const QString &query) const -> QSqlQuery;

	[[nodiscard]]
	auto prepare(const QString &query) const -> QSqlQuery;

	Q_INVOKABLE bool insertDrinkType() const;

	Q_INVOKABLE bool deleteDrinkType(int rowId) const;

	Q_INVOKABLE bool setDrinkTypeIcon(int rowId, const QString &icon) const;

private:
	QSqlDatabase mDb;

	auto exec(const QString &path, const QMap<QString, QVariant> &values) const -> bool;

	auto initDb() const -> bool;
};
