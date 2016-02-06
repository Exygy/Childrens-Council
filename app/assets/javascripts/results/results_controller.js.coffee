ResultsController = ($scope, $location, SearchService) ->
  $scope.data = SearchService.data

  $scope.nextPage = ->
    console.log "start loader animation"
    SearchService.nextPage () ->
      console.log "stop loader animation"

  $scope.postSearch = ->
    console.log "start loader animation"
    SearchService.postSearch () ->
      console.log "stop loader animation"

ResultsController.$inject = ['$scope', '$location', 'SearchService']
angular.module('CCR').controller('ResultsController', ResultsController)
