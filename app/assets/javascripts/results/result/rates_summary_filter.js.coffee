MonthlyRatesToSummaryFilter = ->
  (monthlyRateValue) ->
    if monthlyRateValue
      "approximately $#{monthlyRateValue}/month"
    else
      'n/a'

angular.module('CCR').filter('monthlyRatesToSummary', MonthlyRatesToSummaryFilter)
