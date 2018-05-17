RatesController =  ->
  return @

RatesController.$inject = []

angular
  .module('CCR')
  .component('rates', {
    bindings:
      rates: '<'
    controller: RatesController
    templateUrl: "/assets/provider/rates/rates.html"
  })
