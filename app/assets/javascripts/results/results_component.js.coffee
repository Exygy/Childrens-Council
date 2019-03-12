ResultsController = ($timeout, $anchorScroll, CompareService, ResultsService, SearchService, $auth, $scope) ->
  $ctrl = @

  $ctrl.$onInit = ->
    $ctrl.parent = $auth.currentUser()
    $ctrl.providerIdsToCompare = CompareService.data.providerIds
    $ctrl.data = ResultsService.searchResultsData
    $ctrl.filters = ResultsService.filters
    $ctrl.settings = ResultsService.searchSettings
    $ctrl.showMap = false
    if !$ctrl.data && $ctrl.parent
      SearchService.postSearch()

  $ctrl.postSearch = () ->
    SearchService.postSearch()
    $anchorScroll('search-results-wrapper')

  $ctrl.isCriteriaSearch = () ->
    $ctrl.settings.searchType == 'criteria'

  $scope.$on 'search-service:updated', (event, service) ->
    service.postSearch()

  $timeout $anchorScroll('search-results-wrapper')

  return $ctrl

ResultsController.$inject = ['$timeout', '$anchorScroll', 'CompareService', 'ResultsService', 'SearchService', '$auth', '$scope']

angular
  .module('CCR')
  .component('results', {
    controller: ResultsController
    templateUrl: "results/results.html"
  })
