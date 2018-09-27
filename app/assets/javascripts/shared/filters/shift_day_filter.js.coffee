ShiftDayFilter = () ->
  (shiftDays, current_day) ->
    for shiftDay in shiftDays
      if shiftDay.day == current_day
        return shiftDay

ShiftDayFilter.$inject = []
angular.module('CCR').filter('shiftDay', ShiftDayFilter)
