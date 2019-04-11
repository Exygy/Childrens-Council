RatesService = (AgeToAgeGroupService) ->
  rateTypes = [
    'ftMonthly',
    'ftWeekly',
    'ftDaily',
    'ftHourly',
    'ftOther',
    'ptMonthly',
    'ptWeekly',
    'ptDaily',
    'ptHourly',
    'ptOther'
  ]

  selectRateDataOnly = (rate) ->
    rateData = {}
    rateTypes.forEach (type) ->
      rateData[type] = rate[type] if rate[type]
    rateData

  rateIsInAgeGroups = (ageGroups, rate) ->
    ageGroups.indexOf(rate.ageGroup) > -1

  @selectRatesForAge = (rates, ageInWeeks) ->
    # Select only the providers' rates for age groups that include the given age
    ageGroups = AgeToAgeGroupService.ageToAgeGroup(ageInWeeks)
    rates.filter((r) -> rateIsInAgeGroups(ageGroups, r))
         .map((r) -> selectRateDataOnly(r))

  @

RatesService.$inject = ['AgeToAgeGroupService']
angular.module('CCR').service('RatesService', RatesService)
