FinancialAssistanceItemController = ->
  $ctrl = @

  @$onInit = () ->
    $ctrl.label = if typeof $ctrl.item == 'string' then $ctrl.item else $ctrl.item.label

  $ctrl

FinancialAssistanceItemController.$inject = []

angular
  .module('CCR')
  .component('financialAssistanceItem', {
    bindings:
      index: '@'
      item: '<'
    controller: FinancialAssistanceItemController
    templateUrl: "provider/financial_assistance/financial_assistance_item/financial_assistance_item.html"
  })
