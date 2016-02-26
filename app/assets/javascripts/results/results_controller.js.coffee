ResultsController = ($scope, $location, ResultsService) ->
  $scope.data = ResultsService.data

  $scope.nextPage = ->
    console.log "start loader animation"
    ResultsService.nextPage () ->
      console.log "stop loader animation"

  $scope.prevPage = ->
    console.log "start loader animation"
    ResultsService.prevPage () ->
      console.log "stop loader animation"

  $scope.isFirstPage = () ->
    $scope.data.current_page == 1

  $scope.isLastPage = () ->
    total_number_of_pages = Math.ceil $scope.data.totalProviders/$scope.data.providersPerPage
    $scope.data.current_page == total_number_of_pages



  # View toggler
  $scope.view_mode = { list: true, map: false }
  $scope.toggleView = ->
    $scope.view_mode.map = !$scope.view_mode.map
    $scope.view_mode.list = !$scope.view_mode.list

ResultsController.$inject = ['$scope', '$location', 'ResultsService']
angular.module('CCR').controller('ResultsController', ResultsController)
