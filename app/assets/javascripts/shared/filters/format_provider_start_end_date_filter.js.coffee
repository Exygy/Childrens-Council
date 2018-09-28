FormatProviderStartEndDateFilter = ->
  (date) ->
    date_parts = date.split(':')
    time = date_parts[0] + ':' + date_parts[1]
    if (date_parts[0] - 12) > 0
      ampm = "PM"
      hour = date_parts[0] - 12
      if hour == 0
        hour = "12"
    else
      ampm = "AM"
      hour = date_parts[0]
    return hour + ':' + date_parts[1] + " " + ampm

FormatProviderStartEndDateFilter.$inject = []

angular.module('CCR').filter('formatProviderStartEndDate', FormatProviderStartEndDateFilter)
