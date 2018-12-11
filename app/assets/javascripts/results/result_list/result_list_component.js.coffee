ResultListController = (CompareService) ->
  $ctrl = @
  $ctrl.data
  $ctrl.providerIdsToCompare = CompareService.providerIdsToCompare

  return $ctrl

ResultListController.$inject = ['CompareService']

angular
  .module('CCR')
  .component('resultList', {
    bindings:
      data: '<'
    controller: ResultListController
    templateUrl: "results/result_list/result_list.html"
  })
