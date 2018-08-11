ResultMapController = ($scope, $location) ->
  $ctrl = @

  $ctrl.$onInit = ->
    initResultList($ctrl.searchResultsData)

  $ctrl.$onChanges = ->
    initResultList($ctrl.searchResultsData)

  initResultList = (searchResultsData) ->
    $scope.providers = searchResultsData.content
    $scope.number = searchResultsData.number
    $scope.numberOfElements = searchResultsData.numberOfElements
    $scope.totalElements = searchResultsData.totalElements
    $scope.firstPage = searchResultsData.first
    $scope.lastPage = searchResultsData.last

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
      searchResultsData: '<'
    controller: ResultMapController
    templateUrl: "results/result_map/result_map.html"
  })
