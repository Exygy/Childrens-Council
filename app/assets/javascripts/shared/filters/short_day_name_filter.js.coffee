ShortDayNameFilter = () ->
  (day) ->
    return day.substring(0, 3);

ShortDayNameFilter.$inject = []
angular.module('CCR').filter('shortDayName', ShortDayNameFilter)
