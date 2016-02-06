SearchController = ($scope, $state, SearchService) ->
  $scope.parent = SearchService.parent

  $scope.submitSearch = ->
    $state.go('results')
    # SearchService.postSearch ->


SearchController.$inject = ['$scope', '$state', 'SearchService']
angular.module('CCR').controller('SearchController', SearchController)
