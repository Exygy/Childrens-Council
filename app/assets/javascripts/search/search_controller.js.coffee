SearchController = ($scope, $state, SearchService) ->
  $scope.parent = SearchService.parent
  $scope.search_params = SearchService.search_params

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

  $scope.toggleCareTypeIdSelection = (care_type_id) ->
    idx = $scope.search_params.care_type_ids.indexOf care_type_id
    if idx > -1
      $scope.search_params.care_type_ids.splice idx, 1
    else
      $scope.search_params.care_type_ids.push care_type_id

SearchController.$inject = ['$scope', '$state', 'SearchService']
angular.module('CCR').controller('SearchController', SearchController)
