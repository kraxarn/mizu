#include "settings.hpp"

#include <QDateTime>

Settings::Settings(QObject *parent)
	: QObject(parent),
	mSettings(this)
{
}

auto Settings::dailyGoal() const -> uint
{
	return mSettings.value("daily_goal").toUInt();
}

void Settings::setDailyGoal(const uint value)
{
	mSettings.setValue("daily_goal", value);
	emit dailyGoalChanged();
}
