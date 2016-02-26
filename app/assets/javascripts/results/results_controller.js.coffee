ResultsController = ($scope, $location, SearchService) ->
  $scope.data = SearchService.data

  $scope.nextPage = ->
    console.log "start loader animation"
    SearchService.nextPage () ->
      console.log "stop loader animation"

  $scope.prevPage = ->
    console.log "start loader animation"
    SearchService.prevPage () ->
      console.log "stop loader animation"

  $scope.postSearch = ->
    console.log "start loader animation"
    SearchService.postSearch () ->
      console.log "stop loader animation"

  # View toggler
  $scope.view_mode = { list: true, map: false }
  $scope.toggleView = ->
    $scope.view_mode.map = !$scope.view_mode.map
    $scope.view_mode.list = !$scope.view_mode.list

ResultsController.$inject = ['$scope', '$location', 'SearchService']
angular.module('CCR').controller('ResultsController', ResultsController)
