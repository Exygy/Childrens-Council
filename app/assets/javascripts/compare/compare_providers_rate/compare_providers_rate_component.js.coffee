CompareProvidersRateController = (RatesService) ->
  $ctrl = @
  $ctrl.ratesForAge = RatesService.selectRatesForAge($ctrl.rates, $ctrl.child.ageWeeks)

  $ctrl

CompareProvidersRateController.$inject = ['RatesService']

angular
  .module('CCR')
  .component('compareProvidersRate', {
    bindings:
      rates: '<'
      child: '<'
    controller: CompareProvidersRateController
    templateUrl: "compare/compare_providers_rate/compare_providers_rate.html"
  })
