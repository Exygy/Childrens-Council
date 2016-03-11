ScheduleHoursToSummary = ($rootScope, $filter) ->
  (schedule_hours) ->
    scheduleHourToString = (schedule_hour) ->
      if !schedule_hour.closed
        start_date = $filter('date')(schedule_hour.start_time, 'h:mma', 'UTC')
        end_date = $filter('date')(schedule_hour.end_time, 'h:mma', 'UTC')
        return start_date.replace(':00', '')+'-'+end_date.replace(':00', '')
      else
        false

    scheduleDayToFirstChar = (schedule_hour) ->
      day_first_char = false
      if $rootScope.data['schedule_days'][schedule_hour.schedule_day_id]
        day_first_char = $rootScope.data['schedule_days'][schedule_hour.schedule_day_id].name.charAt(0)
      day_first_char

    summary_hours = {}
    for schedule_hour in schedule_hours
      hour_key = scheduleHourToString(schedule_hour)
      if hour_key
        summary_hours[hour_key] = [] if !summary_hours[hour_key]
        summary_hours[hour_key].push scheduleDayToFirstChar(schedule_hour)

    summary_hours_strings = []
    for hours,days of summary_hours
      if days.length == week_days.length
        summary_hours_strings.push 'Every day, '+hours.toLowerCase()
      else
        if days.length > 1
          summary_hours_strings.push days[0]+'-'+days[days.length-1]+', '+hours.toLowerCase()
        else
          summary_hours_strings.push days[0]+', '+hours.toLowerCase()
    summary_hours_strings.join(' - ')

ScheduleHoursToSummary.$inject = ['$rootScope', '$filter']
angular.module('CCR').filter('scheduleHoursToSummary', ScheduleHoursToSummary)
