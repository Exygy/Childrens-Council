ResultsController = ($timeout, $anchorScroll, ResultsService, SearchService, $auth, $scope) ->
  $ctrl = @
  $ctrl.parent = $auth.currentUser()

  $ctrl.$onInit = ->
    $ctrl.data = ResultsService.searchResultsData
    $ctrl.filters = ResultsService.filters
    $ctrl.showMap = false
    if !$ctrl.data && $ctrl.parent
      SearchService.postSearch()


  $ctrl.resultsFromNum = ->
    ($ctrl.data.currentPage * $ctrl.data.pageSize) + 1

  $ctrl.resultsToNum = ->
    ($ctrl.data.currentPage + 1) * $ctrl.data.pageSize

  $scope.$on 'search-service:updated', (event, service) ->
    service.postSearch()

  $timeout $anchorScroll('search-results-wrapper')

  return $ctrl

ResultsController.$inject = ['$timeout', '$anchorScroll', 'ResultsService', 'SearchService', '$auth', '$scope']

angular
  .module('CCR')
  .component('results', {
    controller: ResultsController
    templateUrl: "results/results.html"
  })
