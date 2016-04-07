SearchController = ($scope, $state, $controller, SearchService) ->
  $controller 'ApplicationController', {$scope: $scope}
  $scope.parent = SearchService.parent
  $scope.filters = SearchService.filters
  $scope.settings = SearchService.settings
  $scope.settings.contact_type = ''
  $scope.settings.show_why_asking = false
  $scope.loading = false

  validateForm = () ->
    for field_name, field_obj of $scope.searchForm
      $scope.searchForm[field_name].$setDirty() if field_name[0] != '$';

  $scope.submitSearch = ->
    validateForm()
    if $scope.searchForm.$valid
      $scope.loading = true
      SearchService.postSearch () ->
        $state.go('results')
    else
      $("html, body").animate({ scrollTop: $('.ng-invalid').not('form').offset().top - 50 }, 800);
    return

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

  $scope.setContactType = (type) ->
    $scope.settings.contact_type = type

SearchController.$inject = ['$scope', '$state', '$controller', 'SearchService']
angular.module('CCR').controller('SearchController', SearchController)
