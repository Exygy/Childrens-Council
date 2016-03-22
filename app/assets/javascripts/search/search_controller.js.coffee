SearchController = ($scope, $state, SearchService) ->
  $scope.parent = SearchService.parent
  $scope.settings = SearchService.settings

  validateForm = () ->
    for field_name, field_obj of $scope.parent
      if $scope.searchForm[field_name]
        $scope.searchForm[field_name].$setDirty()

  $scope.submitSearch = ->
    validateForm()
    if $scope.searchForm.$valid
      SearchService.postSearch () ->
        $state.go('results')

  $scope.addItem = (collection) ->
    collection.push('')

  $scope.removeItem = (collection, index) ->
    collection = collection.splice(index, 1)

  $scope.hasFinalValue = (collection) ->
    if collection
      collection[collection.length - 1] != ''
    else
      false

  $scope.setLocationType = (type) ->
    $scope.settings.location_type = type

SearchController.$inject = ['$scope', '$state', 'SearchService']
angular.module('CCR').controller('SearchController', SearchController)
