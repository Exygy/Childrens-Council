CompareController = (ProviderService, DataService, $modal, $auth, $timeout) ->
  $ctrl = @
  $ctrl.providerIds = ProviderService.providerIdsToCompare

  $ctrl.$onInit = () ->
    $ctrl.providers = ProviderService.providerIdsToCompare.map((id) ->
      DataService.searchResultsData.providers.find((p) ->
        p.providerId == id
      )
    )

  return $ctrl

CompareController.$inject = ['ProviderService', 'DataService', '$modal', '$auth', '$timeout']

angular.module('CCR').controller('CompareController', CompareController)

angular
  .module('CCR')
  .component('compare', {
    bindings:
      token: '<'
    controller: CompareController
    templateUrl: "compare/compare.html"
  })
