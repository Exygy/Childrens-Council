ProviderController = ($scope, ProviderService, ResultsService, SearchService, $location, amplitudejs) ->
  $ctrl = @

  $ctrl.hasSearchResult = ResultsService.searchResultsData && ResultsService.searchResultsData.providers.length > 0
  $ctrl.$onInit = () ->
    ProviderService.get $ctrl.id, (provider) ->
      filterProviders = SearchService.covid19ProvidersOnlyFilter([provider])
      $scope.providerIsOpenDuringCovd19 = filterProviders.length > 0
      $scope.provider = provider

      amplitudejs.logEvent('PAGE_VIEW', { 
        pathname: $location.path()
      })

  return $ctrl

ProviderController.$inject = [
  '$scope',
  'ProviderService',
  'ResultsService',
  'SearchService', 
  '$location', 
  'amplitudejs'
]

angular
  .module('CCR')
  .component('provider', {
    bindings:
      id: '<'
    controller: ProviderController
    templateUrl: "provider/provider.html"
  })
