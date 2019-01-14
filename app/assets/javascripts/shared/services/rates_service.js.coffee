RatesService = (AgeToAgeGroupService) ->
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

  rateData = (rate) ->
    rate_data = {}
    for rate_field in rateValueFields()
      if rate[rate_field]
        rate_data[rate_field] = rate[rate_field]
    return rate_data

  rateIsInAgeGroups = (age_groups, rate) ->
    age_groups.indexOf(rate.ageGroup) > -1

  @selectRatesForAge = (rates, age_in_weeks) ->
    age_groups = AgeToAgeGroupService.ageToAgeGroup(age_in_weeks)
    rates.filter((r) -> rateIsInAgeGroups(age_groups, r))
         .map((r) -> rateData(r))

  @

RatesService.$inject = ['AgeToAgeGroupService']
angular.module('CCR').service('RatesService', RatesService)
