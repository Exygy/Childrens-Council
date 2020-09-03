  # validateRate = () ->
  #   $scope.minRateError = false
  #   $scope.maxRateError = false

  #   console.log('validateRate')
  #   console.log(filters.monthlyRate[0] && isNaN(filters.monthlyRate[0]) )
  #   console.log(filters.monthlyRate[0] && isNaN(filters.monthlyRate[0]) )

  #   if filters.monthlyRate[0] && isNaN(filters.monthlyRate[0]) 
  #     $scope.minRateError = true
  #   if filters.monthlyRate[1] && isNaN(filters.monthlyRate[1])
  #     $scope.maxRateError = true

  #   return

  #   return $scope.minRateError || $scope.maxRateError

ChildModalController = ($scope, $modalInstance, $anchorScroll, ResultsService, SearchService, DataService, childId) ->
  $scope.child = ResultsService.parent.children[childId]
  $scope.filters = DataService.filters
  cached_child = angular.copy $scope.child

  $modalInstance.result.catch () ->
    # modal has been dismissed
    resetChild()

  $scope.postSearch = ->
    console.log(angular.element($('form.ttttt')[0]).controller().constructor.name)

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
