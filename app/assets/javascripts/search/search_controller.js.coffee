SearchController = ($scope, $state, SearchService) ->
  $scope.parent = SearchService.parent
  $scope.provider = SearchService.search_params

  $scope.parentFieldModeEmail = true

  $scope.toggleParentFieldMode = () ->
    $scope.parentFieldModeEmail = !$scope.parentFieldModeEmail

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
