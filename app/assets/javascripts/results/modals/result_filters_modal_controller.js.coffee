ResultFiltersModalController = ($scope, $modalInstance, $anchorScroll, ResultsService, SearchService) ->
  cached_filters = null

  init = ->
    cached_filters = angular.copy ResultsService.filters
    $modalInstance.result.catch () ->
      # modal has been dismissed
      resetFilters()

  $scope.postSearch = ->
    ResultsService.filters.settings = {} unless ResultsService.filters.settings
    ResultsService.filters.settings.searchingByMapArea = false
    SearchService.postSearch()
    $modalInstance.close()
    $anchorScroll('search-results-wrapper')

  $scope.cancel = ->
    $modalInstance.dismiss('cancel')

  resetFilters = ->
    for filter_key, filter_value of ResultsService.filters
      if ResultsService.filters[filter_key] != cached_filters[filter_key]
        ResultsService.filters[filter_key] = cached_filters[filter_key]

  init()

ResultFiltersModalController.$inject = ['$scope', '$modalInstance', '$anchorScroll', 'ResultsService', 'SearchService']
angular.module('CCR').controller('ResultFiltersModalController', ResultFiltersModalController)
