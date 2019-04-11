ProviderController = ($scope, ProviderService, ResultsService) ->
  $ctrl = @

  $ctrl.hasSearchResult = ResultsService.searchResultsData && ResultsService.searchResultsData.providers.length > 0
  $ctrl.$onInit = () ->
    ProviderService.get $ctrl.id, (provider) ->
      $scope.provider = provider

  return $ctrl

ProviderController.$inject = [
  '$scope',
  'ProviderService',
  'ResultsService'
]

angular
  .module('CCR')
  .component('provider', {
    bindings:
      id: '<'
    controller: ProviderController
    templateUrl: "provider/provider.html"
  })
