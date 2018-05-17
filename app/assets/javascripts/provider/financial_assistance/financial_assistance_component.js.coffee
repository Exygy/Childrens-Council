FinancialAssistanceController =  ->
  return @

FinancialAssistanceController.$inject = []

angular
  .module('CCR')
  .component('financialAssistance', {
    bindings:
      provider: '<'
    controller: FinancialAssistanceController
    templateUrl: "/assets/provider/financial_assistance/financial_assistance.html"
  })
