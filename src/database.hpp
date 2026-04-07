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

private:
	QSqlDatabase mDb;

	auto initDb() const -> bool;
};
