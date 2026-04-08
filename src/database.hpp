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
	Q_INVOKABLE bool insertDrinkType() const;

private:
	QSqlDatabase mDb;

	auto exec(const QString &path, const QMap<QString, QVariant> &values = {}) const -> bool;

	auto initDb() const -> bool;
};
