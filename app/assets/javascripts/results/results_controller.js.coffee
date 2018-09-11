ResultsController = ($timeout, $anchorScroll, ResultsService, SearchService, $auth, $scope) ->
  @parent = $auth.currentUser()

  @$onInit = ->
    @data = ResultsService.searchResultsData
    @filters = ResultsService.filters
    @showMap = false
    if !@data && @parent
      SearchService.postSearch()


  $scope.$on 'search-service:updated', (event, service) ->
    service.postSearch()

  $timeout $anchorScroll('search-results-wrapper')

  return

ResultsController.$inject = ['$timeout', '$anchorScroll', 'ResultsService', 'SearchService', '$auth', '$scope']

angular
  .module('CCR')
  .component('results', {
    controller: ResultsController
    templateUrl: "results/results.html"
  })
