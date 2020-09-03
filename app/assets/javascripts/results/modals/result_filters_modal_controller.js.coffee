ResultFiltersModalController = ($scope, $modalInstance, $anchorScroll, ResultsService, SearchService) ->
  cached_filters = null

  init = ->
    cached_filters = angular.copy ResultsService.filters
    $modalInstance.result.catch () ->
      # modal has been dismissed
      resetFilters()

  $scope.validateRate = (isValidating) ->
    $scope.minRateError = false
    $scope.maxRateError = false
    $scope.minHigherThanMaxRateError = false

    if !$scope.formSubmitted
      return true

    if ResultsService.filters.monthlyRate[0] && isNaN(ResultsService.filters.monthlyRate[0]) 
      $scope.minRateError = true
    if ResultsService.filters.monthlyRate[1] && isNaN(ResultsService.filters.monthlyRate[1])
      $scope.maxRateError = true

    if $scope.minRateError || $scope.maxRateError
      return false

    if parseFloat(ResultsService.filters.monthlyRate[0]) > parseFloat(ResultsService.filters.monthlyRate[1])
      $scope.minHigherThanMaxRateError = true
      return false  

    return true

  $scope.postSearch = ->
    $scope.formSubmitted = true

    if !$scope.validateRate()
      $anchorScroll('average-monthly-rate')
      return

    # If the user has entered location information, clear the searching
    # by map area setting
    ResultsService.filters.settings = {} unless ResultsService.filters.settings
    if locationSelected()
      ResultsService.filters.settings.searchingByMapArea = false
    SearchService.postSearch()
    $modalInstance.close()
    $anchorScroll('search-results-wrapper')

  $scope.cancel = ->
    $modalInstance.dismiss('cancel')

  locationSelected = ->
    _.some(
      [
        ResultsService.filters.addresses,
        ResultsService.filters.zips,
        ResultsService.filters.neighborhoods
      ],
      (locations) ->
        !_.isEmpty(locations) && !_.isEmpty(locations[0])
    )

  resetFilters = ->
    for filter_key, filter_value of ResultsService.filters
      if ResultsService.filters[filter_key] != cached_filters[filter_key]
        ResultsService.filters[filter_key] = cached_filters[filter_key]

  init()

ResultFiltersModalController.$inject = ['$scope', '$modalInstance', '$anchorScroll', 'ResultsService', 'SearchService']
angular.module('CCR').controller('ResultFiltersModalController', ResultFiltersModalController)
