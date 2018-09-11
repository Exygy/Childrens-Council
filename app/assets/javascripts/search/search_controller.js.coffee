SearchController = ($scope, $state, SearchService, $modal) ->
  $ctrl = @
  $scope.filterData = SearchService.filterData
  $scope.filters = SearchService.filters
  $scope.parent = SearchService.parent
  $scope.searchSettings = SearchService.searchSettings
  $scope.searchSettings.contact_type = ''
  $scope.searchSettings.show_why_asking = false
  $scope.loading = SearchService.searchResultsData.isLoading
  $scope.locationTabs =
    address:
      active: $scope.searchSettings.locationType == 'address'
    zipCodes:
      active: $scope.searchSettings.locationType == 'zipCodes'
    neighborhoods:
      active: $scope.searchSettings.locationType == 'neighborhoods'

  $ctrl.setLocationTabs = () ->
    $scope.locationTabs =
      address:
        active: $scope.searchSettings.locationType == 'address'
      zipCodes:
        active: $scope.searchSettings.locationType == 'zipCodes'
      neighborhoods:
        active: $scope.searchSettings.locationType == 'neighborhoods'

  $scope.$on 'search-service:updated', (event, service) ->
    $scope.filters = service.filters
    $scope.parent = service.parent
    $scope.searchSettings = service.searchSettings
    $scope.searchSettings.contact_type = ''
    $ctrl.setLocationTabs()

  $ctrl.$onInit = () ->
    if $ctrl.token
      $modal.open {
        resolve: {
          token: ->
            $ctrl.token
        },
        controller: 'userResetPasswordCtrl',
        templateUrl: 'user/reset_password/reset_password.html'
      }
#    currentParent = $auth.currentUser()
#    if currentParent
#      $scope.parent = currentParent.last_search.parent
#      SearchService.parent = $scope.parent

  $scope.$on 'auth:validation-success', (event, user) ->
#    $scope.parent = user.last_search.parent
#    SearchService.parent = $scope.parent

  $scope.$on 'auth:login-success', (event, user) ->
#    $scope.parent = user.last_search.parent
#    SearchService.parent = $scope.parent

  validateForm = () ->
    for field_name, field_obj of $scope.searchForm
      $scope.searchForm[field_name].$setDirty() if field_name[0] != '$'

  $scope.submitSearch = ->
    validateForm()
    if $scope.searchForm.$valid
      $scope.loading = true
      SearchService.postSearch(
        () -> $state.go('results'),
        {deleteApiKey: true, reset: true},
      )
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
    $scope.searchSettings.locationType = type

  $scope.setContactType = (type) ->
    $scope.searchSettings.contact_type = type

  return $ctrl

SearchController.$inject = ['$scope', '$state', 'SearchService', '$modal']

angular.module('CCR').controller('SearchController', SearchController)

angular
  .module('CCR')
  .component('search', {
    bindings:
      token: '<'
    controller: SearchController
    templateUrl: "search/search.html"
  })
