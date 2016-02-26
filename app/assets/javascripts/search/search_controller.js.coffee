SearchController = ($scope, $state, SearchService) ->
  $scope.parent = SearchService.parent
  $scope.provider = SearchService.search_params

  validateForm = () ->
    for field_name, field_obj of $scope.parent
      $scope.searchForm[field_name].$setDirty()

  $scope.submitSearch = ->
    validateForm()
    if $scope.searchForm.$valid
      SearchService.postSearch () ->
        $state.go('results')

SearchController.$inject = ['$scope', '$state', 'SearchService']
angular.module('CCR').controller('SearchController', SearchController)
