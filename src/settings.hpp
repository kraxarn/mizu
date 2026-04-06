#pragma once

#include <qqmlintegration.h>
#include <QSettings>
#include <QtTypes>

class Settings : public QObject
{
	Q_OBJECT
	QML_ELEMENT

	Q_PROPERTY(uint dailyGoal READ dailyGoal WRITE setDailyGoal NOTIFY dailyGoalChanged)

public:
	explicit Settings(QObject *parent = nullptr);

	[[nodiscard]]
	auto dailyGoal() const -> uint;

	void setDailyGoal(uint value);

signals:
	void dailyGoalChanged();

private:
	QSettings mSettings;
};
