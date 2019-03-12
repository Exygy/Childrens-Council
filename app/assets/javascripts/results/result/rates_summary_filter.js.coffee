MonthlyRatesSummaryFilter = (RatesService, $sce) ->

  # Children's Council's direction for this monthly rate filter is that
  # we should prefer to display the full time monthly rate over the
  # part time rate.
  getMonthlyRate = (rate) ->
    rate.ftMonthly || rate.ptMonthly

  formatRateForDisplay = (rate, providerId) ->
    monthlyRateValue = getMonthlyRate(rate)

    if monthlyRateValue
      "approximately $#{monthlyRateValue}/month"
    else
      providerId = providerId.toString().replace(/[^0-9]/g, '')
      providerLink = "<a href='/providers/#{providerId}/#provider-rates'>see details</a>"
      $sce.trustAsHtml(providerLink)

  (provider, ageInWeeks) ->
    # Select only the providers' rates for age groups that include the given age
    ratesData = RatesService.selectRatesForAge(provider.rates, ageInWeeks)
    return 'n/a' if _.isEmpty(ratesData) || _.every(ratesData, isEmpty)

    # A provider can have multiple age group rates that cover the given age.
    # At this time, Children's Council's direction for handling this case in
    # this monthly rate filter is to use only the first age group rate that
    # is returned from the API.
    rate = ratesData[0]

    # Format the rate as text
    formatRateForDisplay(rate, provider.providerId)

MonthlyRatesSummaryFilter.$inject = ['RatesService', '$sce']

angular.module('CCR').filter('monthlyRatesToSummary', MonthlyRatesSummaryFilter)
