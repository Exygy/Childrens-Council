ChildModalController = ($scope, $modalInstance, $anchorScroll, ResultsService, SearchService, DataService, childId) ->
  $scope.child = ResultsService.parent.children[childId]
  $scope.filters = DataService.filters
  cached_child = angular.copy $scope.child

  $modalInstance.result.catch () ->
    # modal has been dismissed
    resetChild()

  $scope.postSearch = ->
    SearchService.postSearch()
    $modalInstance.close()
    $anchorScroll('search-results-wrapper')

  $scope.cancel = ->
    $modalInstance.dismiss('cancel')

  resetChild = ->
    for filter_key, filter_value of $scope.child
      if $scope.child[filter_key] != cached_child[filter_key]
        $scope.child[filter_key] = cached_child[filter_key]

ChildModalController.$inject = ['$scope', '$modalInstance', '$anchorScroll', 'ResultsService', 'SearchService', 'DataService', 'childId']
angular.module('CCR').controller('ChildModalController', ChildModalController)
