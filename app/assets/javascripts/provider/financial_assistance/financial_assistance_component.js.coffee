FinancialAssistanceController = ($scope, FinancialAssistanceService) ->

  @$onInit = () ->
    $scope.descriptions = FinancialAssistanceService.descriptions

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
