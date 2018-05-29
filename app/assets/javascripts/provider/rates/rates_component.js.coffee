RatesController = ($scope)  ->

  return @

RatesController.$inject = ['$scope']

angular
  .module('CCR')
  .component('rates', {
    bindings:
      rates: '<'
    controller: RatesController
    templateUrl: "provider/rates/rates.html"
  })
