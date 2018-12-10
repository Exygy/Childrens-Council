ResultListController = (ProviderService) ->
  $ctrl = @
  $ctrl.data
  $ctrl.providerIdsToCompare = ProviderService.providerIdsToCompare

  return $ctrl

ResultListController.$inject = ['ProviderService']

angular
  .module('CCR')
  .component('resultList', {
    bindings:
      data: '<'
    controller: ResultListController
    templateUrl: "results/result_list/result_list.html"
  })
