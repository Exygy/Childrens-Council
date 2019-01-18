ScheduleHoursToSummary = ($filter, DataService, DateFormatterService) ->
  (scheduleHours) ->

    scheduleHourToString = (scheduleHour) ->
      if !scheduleHour.closed
        startTime = DateFormatterService.formatTime(scheduleHour.startTime)
        endTime = DateFormatterService.formatTime(scheduleHour.endTime)
        return startTime + '-' + endTime
      else
        false


    abbreviateDay = (fullDayName) ->
      switch
        when fullDayName == 'Sunday' then 'Su'
        when fullDayName == 'Saturday' then 'Sa'
        when fullDayName == 'Thursday' then 'Th'
        else fullDayName[0]

    weekDays = DataService.filterData.days
    summaryHours = {}
    for scheduleHour in scheduleHours
      hourKey = scheduleHourToString(scheduleHour)
      if hourKey
        summaryHours[hourKey] = [] if !summaryHours[hourKey]
        summaryHours[hourKey].push scheduleHour.day

    summaryHoursStrings = []

    for hours, days of summaryHours
      if days.length == weekDays.length
        summaryHoursStrings.push 'Every day, ' + hours.toLowerCase()
      else
        days = days.sort((a,b) ->
          return -1 if weekDays.indexOf(a) < weekDays.indexOf(b)
          return 1 if weekDays.indexOf(a) > weekDays.indexOf(b)
          return 0 if weekDays.indexOf(a) == weekDays.indexOf(b)
        )
        if days.length == 5 and days[0] == 'Monday' and days[4] == 'Friday'
          summaryHoursStrings.push 'M-F, ' + hours.toLowerCase()
        else if days.length == 6 and days[0] == 'Monday' and days[5] == 'Saturday'
          summaryHoursStrings.push 'M-Sa, ' + hours.toLowerCase()
        else
          abbrDays = days.reduce ((sum, val) -> sum + abbreviateDay(val)), ''
          summaryHoursStrings.push abbrDays + ', ' + hours.toLowerCase()

    summaryHoursStrings.join(' - ')

ScheduleHoursToSummary.$inject = ['$filter', 'DataService', 'DateFormatterService']
angular.module('CCR').filter('scheduleHoursToSummary', ScheduleHoursToSummary)
