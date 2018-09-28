ScheduleDaysToTextFilter = (DataService) ->
  (days) ->
    if days?
      allDays = DataService.filterData.days
      days = days.sort (a, b) -> allDays.indexOf(a) - allDays.indexOf(b)
      if days.length == 5 and days[0] == 'Monday' and days[days.length-1] == 'Friday'
        return 'Monday - Friday'
      else if days.length == 2 and days[0] == 'Saturday' and days[days.length-1] == 'Sunday'
        return 'Saturday - Sunday'
      else if days.length == 7
        return 'All week'
      else if days.length == 0
        return 'None'
      else
        return EntitiesToString(days)

ScheduleDaysToTextFilter.$inject = ['DataService']

angular.module('CCR').filter('scheduleDaysToText', ScheduleDaysToTextFilter)
