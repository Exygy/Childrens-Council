ResultsController = ($timeout, $anchorScroll, ResultsService, SearchService, ProviderService) ->
  @data = ResultsService.searchResultsData
  @filters = ResultsService.filters
  @showMap = false

  @searchParams = ->
    return $location.search();

  $timeout $anchorScroll('search-results-wrapper')

  return

ResultsController.$inject = ['$timeout', '$anchorScroll', 'ResultsService', 'SearchService', 'ProviderService']

angular
  .module('CCR')
  .component('results', {
    controller: ResultsController
    templateUrl: "results/results.html"
  })
