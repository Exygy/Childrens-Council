FinancialAssistanceController = ($scope, DataService) ->

  @$onInit = () ->
    $scope.financialAssistance = DataService.providerData.financialAssistance
    $scope.getFinancialAssist = (label) ->
      DataService.providerData.financialAssistance.find((a) -> a.label == label)

  return @

FinancialAssistanceController.$inject = ['$scope', 'DataService']

angular
  .module('CCR')
  .component('financialAssistance', {
    bindings:
      provider: '<'
    controller: FinancialAssistanceController
    templateUrl: "provider/financial_assistance/financial_assistance.html"
  })
