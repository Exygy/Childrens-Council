ResultController = ($scope, DataService, RatesService) ->
  $ctrl = @

  $ctrl.$onInit = ->
    $ctrl.ratesByAge = {}
    $ctrl.ageWeeks = DataService.parent.children[0].ageWeeks

  $ctrl.selectRatesForAge = ->
    return $ctrl.ratesByAge[$ctrl.ageWeeks] if _.has($ctrl.ratesByAge, $ctrl.ageWeeks)
    ratesData = RatesService.selectRatesForAge($ctrl.provider.rates, $ctrl.ageWeeks)
    if _.isEmpty(ratesData) || _.every(ratesData, isEmpty)
      $ctrl.ratesByAge[$ctrl.ageWeeks] = null
    else
      # A provider can have multiple age group rates that cover the given age.
      # At this time, Children's Council's direction for handling this case in
      # a search result is to use only the first age group rate that is
      # returned from the API.
      $ctrl.ratesByAge[$ctrl.ageWeeks] = ratesData[0]
      $ctrl.ratesByAge[$ctrl.ageWeeks]

  $ctrl.providerHasOnlyNonMonthlyRates = ->
    rates = $ctrl.selectRatesForAge($ctrl.ageWeeks)
    return !_.isEmpty(rates) && !rates.ftMonthly && !rates.ptMonthly

  $ctrl.getProviderMonthlyRateValue = ->
    rates = $ctrl.selectRatesForAge($ctrl.ageWeeks)
    return null if _.isEmpty(rates)

    # Children's Council's direction is that we should prefer to display the
    # full time monthly rate over the part time rate.
    rates.ftMonthly || rates.ptMonthly

  return $ctrl

ResultController.$inject = ['$scope', 'DataService', 'RatesService']

angular
  .module('CCR')
  .component('result', {
    bindings:
      infoGridFormat: '@'
      provider: '<'
    controller: ResultController
    templateUrl: "results/result/result.html"
  })
