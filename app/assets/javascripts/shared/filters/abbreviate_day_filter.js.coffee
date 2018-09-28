AbbreviateDay = () ->
  (day_of_week) ->
    if day_of_week.length > 3 then day_of_week.substr(0, 3) else day_of_week

angular.module('CCR').filter('abbreviateDay', AbbreviateDay)
