angular
  .module('CCR')
  .component('financialAssistanceItem', {
    bindings:
      item: '<'
      index: '@'
    controller: [() ->
      @label = if typeof @item == 'string' then @item else @item.label
      @
    ]
    templateUrl: "provider/financial_assistance/financial_assistance_item.html"
  })
