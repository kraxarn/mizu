#include "drinktypemodel.hpp"

#include <QSqlError>
#include <QSqlQuery>

DrinkTypeModel::DrinkTypeModel(QObject *parent)
	: QAbstractListModel(parent),
	mDb(this)
{
}

auto DrinkTypeModel::roleNames() const -> QHash<int, QByteArray>
{
	return {
		{
			{static_cast<int>(ItemRole::RowId), "rowId"},
			{static_cast<int>(ItemRole::IconName), "iconName"},
			{static_cast<int>(ItemRole::Name), "name"},
			{static_cast<int>(ItemRole::Impact), "impact"},
		}
	};
}

auto DrinkTypeModel::rowCount([[maybe_unused]] const QModelIndex &parent) const -> int
{
	QSqlQuery query = mDb.exec(QStringLiteral(
		// language=sql
		"select count(*) from drink_types"
	));

	return query.next()
		? query.value(0).toInt()
		: 0;
}

auto DrinkTypeModel::data(const QModelIndex &index, const int role) const -> QVariant
{
	QString query;
	switch (static_cast<ItemRole>(role))
	{
		case ItemRole::RowId:
			query = QStringLiteral(
				// language=sql
				"select rowid from drink_types limit 1 offset :offset"
			);
			break;

		case ItemRole::IconName:
			query = QStringLiteral(
				// language=sql
				"select icon from drink_types limit 1 offset :offset"
			);
			break;

		case ItemRole::Name:
			query = QStringLiteral(
				// language=sql
				"select name from drink_types limit 1 offset :offset"
			);
			break;

		case ItemRole::Impact:
			query = QStringLiteral(
				// language=sql
				"select impact from drink_types limit 1 offset :offset"
			);
			break;

		default:
			return {};
	}

	QSqlQuery sqlQuery = mDb.prepare(query);
	sqlQuery.bindValue(QStringLiteral(":offset"), index.row());

	return sqlQuery.exec() && sqlQuery.next()
		? sqlQuery.value(0)
		: QVariant();
}
