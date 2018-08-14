ResultsController = ($timeout, $anchorScroll, ResultsService) ->
  @data = ResultsService.searchResultsData
  @filters = ResultsService.filters
  @showMap = false

  $timeout $anchorScroll('search-results-wrapper')

  return

ResultsController.$inject = ['$timeout', '$anchorScroll', 'ResultsService']

angular
  .module('CCR')
  .component('results', {
    controller: ResultsController
    templateUrl: "results/results.html"
  })
