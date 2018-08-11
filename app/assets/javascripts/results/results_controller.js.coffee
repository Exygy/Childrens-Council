ResultsController = ($timeout, $anchorScroll, ResultsService, SearchService, ProviderService) ->
  @data = ResultsService.searchResultsData
  @filters = ResultsService.filters

  @searchParams = ->
    return $location.search();

  # Init sticky sidebar nav after ng-includes loads sidebar markup
  # $scope.$on '$includeContentLoaded', (event, src) ->
  #   if src.indexOf 'result_filters' > -1
  #     $scope.initFoundation()
  #     $scope.setSideNavWidth()

  @toggleMap = (provider) ->
    if provider.map
      delete provider.map
    else
      provider.map = ProviderService.providerMap(provider)

  $timeout $anchorScroll('search-results-wrapper')

  return

ResultsController.$inject = ['$timeout', '$anchorScroll', 'ResultsService', 'SearchService', 'ProviderService']

angular
  .module('CCR')
  .component('results', {
    controller: ResultsController
    templateUrl: "results/results.html"
  })
