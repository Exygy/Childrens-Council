RatesSummaryFilter = (AgeToAgeGroupService) ->

  rateValueFields = ->
    return [
      'ftMonthly',
      'ftWeekly',
      'ftDaily',
      'ftHourly',
      'ftOther',
      'ptMonthly',
      'ptWeekly',
      'ptDaily',
      'ptHourly',
      'ptOther']

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

  rateData = (rate) ->
    rate_data = {}
    for rate_field in rateValueFields()
      if rate[rate_field]
        rate_data[rate_field] = rate[rate_field]
    return rate_data

  hasRateData = (rate_data) ->
    for key of rate_data
      if rate_data.hasOwnProperty(key)
        return true
    return false

  ratesToRateToDisplay = (rates_to_display) ->
    if rates_to_display.length
      for field_name of rates_to_display[0]
        return '$' + rates_to_display[0][field_name] + rateDataFieldNameToString(field_name)

  rateIsInAgeGroup = (age_groups, rate) ->
    age_groups.indexOf(rate.ageGroup) > -1

  (rates, age_in_weeks) ->
    age_groups = AgeToAgeGroupService.ageToAgeGroup(age_in_weeks)

    rates_to_display = []

    for rate in rates
      if rateIsInAgeGroup(age_groups, rate)
        rate_data = rateData(rate)
        break unless hasRateData(rate_data)
        rates_to_display.push(rate_data)

    rate_to_display = ratesToRateToDisplay(rates_to_display)

    if rate_to_display
      return 'approximately ' + rate_to_display
    else
      return 'n/a'

RatesSummaryFilter.$inject = ['AgeToAgeGroupService']

angular.module('CCR').filter('ratesToSummary', RatesSummaryFilter)
