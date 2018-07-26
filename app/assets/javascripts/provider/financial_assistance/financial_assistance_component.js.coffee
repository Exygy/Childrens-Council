FinancialAssistanceController = ($scope, FinancialAssistanceService) ->

  $scope.descriptions = (name) ->
    return FinancialAssistanceService.descriptions[name]

  return @

FinancialAssistanceController.$inject = ['$scope', 'FinancialAssistanceService']

angular
  .module('CCR')
  .component('financialAssistance', {
    bindings:
      provider: '<'
    controller: FinancialAssistanceController
    templateUrl: "provider/financial_assistance/financial_assistance.html"
  })
