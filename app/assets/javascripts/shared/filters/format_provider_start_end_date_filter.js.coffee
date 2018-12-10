FormatProviderStartEndDateFilter = (DateFormatterService) ->
  (date) ->
    return DateFormatterService.formatTime(date)

FormatProviderStartEndDateFilter.$inject = ['DateFormatterService']

angular.module('CCR').filter('formatProviderStartEndDate', FormatProviderStartEndDateFilter)
