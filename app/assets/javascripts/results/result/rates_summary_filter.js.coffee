RatesSummaryFilter = (RatesService) ->

  rateDataFieldNameToString = (field_name) ->
    if field_name.indexOf('Monthly')
      return '/month'
    if field_name.indexOf('Weekly')
      return '/week'
    if field_name.indexOf('Daily')
      return '/day'
    if field_name.indexOf('Hourly')
      return '/hour'
    if field_name.indexOf('Other')
      return ' - other'
    return ''

  hasRateData = (rate_data) ->
    for key of rate_data
      if rate_data.hasOwnProperty(key)
        return true
    return false

  formatRatesToDisplay = (rates_to_display) ->
    if rates_to_display.length
      for field_name of rates_to_display[0]
        return '$' + rates_to_display[0][field_name] + rateDataFieldNameToString(field_name)

  (rates, age_in_weeks) ->
    ratesData = RatesService.selectRatesForAge(rates, age_in_weeks)
    rates_to_display = ratesData.filter((r) -> hasRateData(r))
    rate_to_display_str = formatRatesToDisplay(rates_to_display)

    if rate_to_display_str
      return 'approximately ' + rate_to_display_str
    else
      return 'n/a'

RatesSummaryFilter.$inject = ['RatesService']

angular.module('CCR').filter('ratesToSummary', RatesSummaryFilter)
