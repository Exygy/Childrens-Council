angular
  .module('CCR')
  .component('financialAssistanceItem', {
    bindings:
      item: '<'
      index: '@'
    templateUrl: "provider/financial_assistance/financial_assistance_item.html"
  })
