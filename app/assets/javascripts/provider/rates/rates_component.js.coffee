RatesController = ($scope)  ->

  $scope.displayRates = (rate_obj) ->
    rates_string = []
    for rate_key of rate_obj
      rate_val = rate_obj[rate_key]
      if rate_val && $scope.displayRate(rate_key)
        rates_string.push "$" + rate_val + $scope.rateUnit(rate_key)
    return rates_string.join(', <br>')

  $scope.displayRate = (rate_unit) ->
    return ['ftDaily','ftHourly','ftMonthly','ftOther','ftWeekly','ptDaily','ptHourly','ptMonthly','ptOther','ptWeekly'].indexOf(rate_unit) > -1

  $scope.rateUnit = (rate_unit) ->
      units =
        'ftDaily': "/day full time",
        'ftHourly': "/hour full time",
        'ftMonthly': "/month full time",
        'ftOther': "other - full time",
        'ftWeekly': "/week full time",
        'ptDaily': "/day part time",
        'ptHourly': "/hour part time",
        'ptMonthly': "/month part time",
        'ptOther': "other - part time",
        'ptWeekly': "/week part time"
      return units[rate_unit]


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
