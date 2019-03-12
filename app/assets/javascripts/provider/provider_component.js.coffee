ProviderController = ($anchorScroll, $scope, $timeout, ProviderService, ResultsService) ->
  $ctrl = @

  $ctrl.hasSearchResult = ResultsService.searchResultsData && ResultsService.searchResultsData.providers.length > 0
  $ctrl.$onInit = () ->
    ProviderService.get $ctrl.id, (provider) ->
      $scope.provider = provider

  $timeout(
    () ->
      $anchorScroll()
    ,
    1000
  )

  return $ctrl

ProviderController.$inject = [
  '$anchorScroll',
  '$scope',
  '$timeout',
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
