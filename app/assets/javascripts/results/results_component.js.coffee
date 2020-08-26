ResultsController = (
  $timeout, $anchorScroll, $auth, $scope,
  CompareService, ResultsService, SearchService
) ->
  $ctrl = @

  $scope.covid19ProvidersOnly = ResultsService.covid19ProvidersOnly
  $scope.filterData = SearchService.filterData

  $scope.weekDaysDropdownSettings =
    showCheckAll: false
    showUncheckAll: false
    scrollableHeight: '400px',
    scrollable: true,
    enableSearch: false
  
  $scope.tttttttt = []
  $scope.weekDays = SearchService.filterData.days.map (day) ->
    return { "label": day, "id": day }

  $ctrl.$onInit = ->
    $ctrl.parent = $auth.currentUser()
    $ctrl.parentFilter = ResultsService.parent
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

  $scope.setLocationType = () ->
    # Reset locations
    ResultsService.filters.addresses = ['']
    ResultsService.filters.zips = ['']
    ResultsService.filters.neighborhoods = ['']

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
