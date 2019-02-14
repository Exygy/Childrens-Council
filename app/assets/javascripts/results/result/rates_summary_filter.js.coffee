MonthlyRatesSummaryFilter = (RatesService) ->

  # Children's Council's direction for this monthly rate filter is that
  # we should prefer to display the full time monthly rate over the
  # part time rate.
  getMonthlyRate = (rate) ->
    rate.ftMonthly || rate.ptMonthly

  formatRateForDisplay = (rate) ->
    monthlyRateValue = getMonthlyRate(rate)

    if monthlyRateValue
      "approximately $#{monthlyRateValue}/month"
    else
      'see details'

  (rates, ageInWeeks) ->
    # Select only the providers' rates for age groups that include the given age
    ratesData = RatesService.selectRatesForAge(rates, ageInWeeks)
    return 'n/a' if _.isEmpty(ratesData) || _.every(ratesData, isEmpty)

    # A provider can have multiple age group rates that cover the given age.
    # At this time, Children's Council's direction for handling this case in
    # this monthly rate filter is to use only the first age group rate that
    # is returned from the API.
    rate = ratesData[0]

    # Format the rate as text
    formatRateForDisplay(rate)

MonthlyRatesSummaryFilter.$inject = ['RatesService']

angular.module('CCR').filter('monthlyRatesToSummary', MonthlyRatesSummaryFilter)
