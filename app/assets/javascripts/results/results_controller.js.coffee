ResultsController = ($scope, $location, $state, $controller, $anchorScroll, ResultsService, ProviderService) ->
  $controller 'ApplicationController', {$scope: $scope}
  $scope.search_result_data = ResultsService.data
  $scope.settings = ResultsService.settings
  $scope.filters = ResultsService.filters
  $scope.parent = ResultsService.parent
  $scope.loading = ResultsService.data.is_loading

  # Init sticky sidebar nav after ng-includes loads sidebar markup
  $scope.$on '$includeContentLoaded', (event, src) ->
    if src.indexOf 'result_filters' > -1
      $scope.initFoundation()
      $scope.setSideNavWidth()

  $scope.nextPage = ->
    if !$scope.isLastPage()
      scrollToTop()
      ResultsService.nextPage()

  $scope.prevPage = ->
    if !$scope.isFirstPage()
      scrollToTop()
      ResultsService.prevPage()

  $scope.postSearch = ->
    scrollToTop()
    ResultsService.postSearch()

  scrollToTop = ->
    $anchorScroll('search-results-wrapper')

  $scope.isFirstPage = () ->
    $scope.search_result_data.current_page == 1

  $scope.isLastPage = () ->
    total_number_of_pages = Math.ceil $scope.search_result_data.totalProviders/$scope.search_result_data.providersPerPage
    $scope.search_result_data.current_page == total_number_of_pages

  $scope.goToProvider = (provider_id) ->
    $scope.loading = true
    $state.go('provider', {id: provider_id})

  $scope.toggleMap = (provider) ->
    if provider.map
      delete provider.map
    else
      provider.map = ProviderService.providerMap(provider)

  # View toggler
  $scope.view_mode = { list: true, map: false }
  $scope.toggleView = ->
    $scope.view_mode.map = !$scope.view_mode.map
    $scope.view_mode.list = !$scope.view_mode.list

  scrollToTop()

ResultsController.$inject = ['$scope', '$location', '$state', '$controller', '$anchorScroll', 'ResultsService', 'ProviderService']
angular.module('CCR').controller('ResultsController', ResultsController)
