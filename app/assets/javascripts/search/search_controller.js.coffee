SearchController = ($scope, $state, $controller, SearchService) ->
  $scope.filterData = SearchService.filterData
  $scope.parent = SearchService.parent
  $scope.filters = SearchService.filters
  $scope.settings = SearchService.settings
  $scope.settings.contact_type = ''
  $scope.settings.show_why_asking = false
  $scope.loading = SearchService.data.is_loading
  $scope.locationTabs =
    near_address:
      active: $scope.settings.locationType == 'near_address'
    zipCodes:
      active: $scope.settings.locationType == 'zipCodes'
    neighborhoods:
      active: $scope.settings.locationType == 'neighborhoods'

  validateForm = () ->
    for field_name, field_obj of $scope.searchForm
      $scope.searchForm[field_name].$setDirty() if field_name[0] != '$';

  $scope.submitSearch = ->
    validateForm()
    if $scope.searchForm.$valid
      $scope.loading = true
      SearchService.postSearch () ->
        $state.go('results', {"product": 'test', "id": 123})
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
    $scope.locationTabs[type].active = true
    $scope.settings.locationType = type

  $scope.setContactType = (type) ->
    $scope.settings.contact_type = type

SearchController.$inject = ['$scope', '$state', '$controller', 'SearchService']

angular
  .module('CCR')
  .component('search', {
    controller: SearchController
    templateUrl: "search/search.html"
  })
