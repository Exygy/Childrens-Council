SearchController = ($scope, $state, SearchService) ->
  $scope.parent = SearchService.parent

  $scope.submitSearch = () ->
    SearchService.postSearch()
    # $state.go('results')

SearchController.$inject = ['$scope', '$state', 'SearchService']
angular.module('CCR').controller('SearchController', SearchController)
