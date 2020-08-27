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
    scrollableHeight: '350px',
    scrollable: true,
    enableSearch: false,
    buttonDefaultText: 'Weeks'

  weekDaysDropdownOnChangeCallback = () ->
    pluralize = if $scope.weekDaysDropDownSelection.length == 1 then '' else 's'
    text = $scope.weekDaysDropDownSelection.length + ' day' + pluralize + ' selected'
    button = text + '<i class="fa fa-caret-down" aria-hidden="true" style="float: right;font-size: 10px;margin-top: 4px;"></i>'

    SearchService.filterData.days = $scope.weekDaysDropDownSelection.map (day) ->
      return day.id

    $('.btn.btn-default.dropdown-toggle').html(button)
    setTimeout () -> 
      $('.btn.btn-default.dropdown-toggle').html(button)
    , 100

  $scope.weekDaysDropDownCallback =
    onInitDone: weekDaysDropdownOnChangeCallback,
    onSelectionChanged: weekDaysDropdownOnChangeCallback
  
  $scope.weekDaysDropDownSelection = []
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
