RatesController =  ->
  return @

RatesController.$inject = []

angular
  .module('CCR')
  .component('rates', {
    bindings:
      rates: '<'
    controller: RatesController
    templateUrl: "provider/rates/rates.html"
  })
