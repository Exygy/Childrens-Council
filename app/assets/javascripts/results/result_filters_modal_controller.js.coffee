ResultFiltersModalController = ($scope, ResultsService, $modalInstance) ->
  cached_filters = null

  init = ->
    cached_filters = angular.copy ResultsService.filters
    $modalInstance.result.catch () ->
      # module has been dismissed
      resetFilters()

  $scope.postSearch = ->
    ResultsService.postSearch()
    $modalInstance.close()

  $scope.cancel = ->
    $modalInstance.dismiss('cancel')

  resetFilters = ->
    for filter_key, filter_value of ResultsService.filters
      if ResultsService.filters[filter_key] != cached_filters[filter_key]
        ResultsService.filters[filter_key] = cached_filters[filter_key]

  init()

ResultFiltersModalController.$inject = ['$scope', 'ResultsService', '$modalInstance']
angular.module('CCR').controller('ResultFiltersModalController', ResultFiltersModalController)
