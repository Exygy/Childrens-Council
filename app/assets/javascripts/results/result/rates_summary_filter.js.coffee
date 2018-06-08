RatesSummaryFilter = ->
  (rates) ->
    console.log(rates)

    return 'approximately $1500/month'

RatesSummaryFilter.$inject = []

angular.module('CCR').filter('ratesToSummary', RatesSummaryFilter)
