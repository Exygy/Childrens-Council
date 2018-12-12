CompareItemController = (CompareService) ->
  $ctrl = @
  $ctrl.data = CompareService.data

  $ctrl.removeProviderFromCompare = (id) ->
    CompareService.removeProviderFromCompare(id)

  $ctrl

CompareItemController.$inject = ['CompareService']

angular
  .module('CCR')
  .component('compareItem', {
    bindings:
      provider: '<'
    controller: CompareItemController
    templateUrl: "compare/compare_item/compare_item.html"
  })
