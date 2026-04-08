#pragma once

#include "database.hpp"

#include <QAbstractListModel>

class DrinkTypeModel : public QAbstractListModel
{
	Q_OBJECT

public:
	explicit DrinkTypeModel(QObject *parent = nullptr);

	[[nodiscard]]
	auto roleNames() const -> QHash<int, QByteArray> override;

	[[nodiscard]]
	auto rowCount(const QModelIndex &parent) const -> int override;

	[[nodiscard]]
	auto data(const QModelIndex &index, int role) const -> QVariant override;

private:
	enum class ItemRole: quint16
	{
		RowId = Qt::UserRole + 1,
		IconName,
		Name,
		Impact,
	};

	Database mDb;
};
