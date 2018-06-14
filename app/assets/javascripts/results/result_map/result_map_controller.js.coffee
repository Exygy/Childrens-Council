ResultMapController = ($scope, $location) ->
  $ctrl = @

  $ctrl.$onInit = ->
    initResultList($ctrl.searchResultData)

  $ctrl.$onChanges = ->
    initResultList($ctrl.searchResultData)

  initResultList = (searchResultData) ->
    $scope.providers = searchResultData.content
    $scope.number = searchResultData.number
    $scope.numberOfElements = searchResultData.numberOfElements
    $scope.totalElements = searchResultData.totalElements
    $scope.firstPage = searchResultData.first
    $scope.lastPage = searchResultData.last

  $scope.prevPage = ->
    $location.search('page', $scope.number - 1)

  $scope.nextPage = ->
    $location.search('page', $scope.number + 1)

  return

ResultMapController.$inject = ['$scope', '$location']

angular
  .module('CCR')
  .component('resultMap', {
    bindings:
      searchResultData: '<'
    controller: ResultMapController
    templateUrl: "results/result_map/result_map.html"
  })
