ProviderController = ($scope, ProviderService, ResultsService, SearchService) ->
  $ctrl = @

  $ctrl.hasSearchResult = ResultsService.searchResultsData && ResultsService.searchResultsData.providers.length > 0
  $ctrl.$onInit = () ->
    ProviderService.get $ctrl.id, (provider) ->
      filterProviders = SearchService.covid19ProvidersOnlyFilter([provider])
      $scope.providerIsOpenDuringCovd19 = filterProviders.length > 0
      $scope.provider = provider

  return $ctrl

ProviderController.$inject = [
  '$scope',
  'ProviderService',
  'ResultsService',
  'SearchService'
]

angular
  .module('CCR')
  .component('provider', {
    bindings:
      id: '<'
    controller: ProviderController
    templateUrl: "provider/provider.html"
  })
