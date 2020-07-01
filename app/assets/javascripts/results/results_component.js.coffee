ResultsController = (
  $timeout, $anchorScroll, $auth, $scope,
  CompareService, ResultsService, SearchService
) ->
  $ctrl = @

  $ctrl.$onInit = ->
    $ctrl.covid19ProvidersOnly = ResultsService.covid19ProvidersOnly
    $ctrl.parent = $auth.currentUser()
    $ctrl.providerIdsToCompare = CompareService.data.providerIds
    $ctrl.data = ResultsService.searchResultsData
    $ctrl.filters = ResultsService.filters
    $ctrl.settings = ResultsService.searchSettings
    $ctrl.showMap = false
    SearchService.postSearch() if !$ctrl.data && $ctrl.parent

  $ctrl.postSearch = () ->
    SearchService.postSearch()
    $anchorScroll('search-results-wrapper')

  $ctrl.isCriteriaSearch = () ->
    $ctrl.settings.searchType == 'criteria'

  $scope.$on 'search-service:updated', (event, service) ->
    service.postSearch()

  $timeout $anchorScroll('search-results-wrapper')

  return $ctrl

ResultsController.$inject = [
  '$timeout', '$anchorScroll', '$auth', '$scope',
  'CompareService', 'ResultsService', 'SearchService'
]

angular
  .module('CCR')
  .component('results', {
    controller: ResultsController
    templateUrl: "results/results.html"
  })
