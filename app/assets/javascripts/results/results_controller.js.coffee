ResultsController = ($scope, $location, $state, $controller, $anchorScroll, ResultsService, ProviderService, $timeout) ->
  $ctrl = @

  $ctrl.$onInit = () ->
    $scope.search_result_data = {}
    search_params = $ctrl.searchParams()
    ResultsService.search $ctrl.searchParams(), (result_data) ->
      $scope.search_result_data = result_data
    return

  $ctrl.searchParams = ->
    return $location.search();

  # Init sticky sidebar nav after ng-includes loads sidebar markup
  # $scope.$on '$includeContentLoaded', (event, src) ->
  #   if src.indexOf 'result_filters' > -1
  #     $scope.initFoundation()
  #     $scope.setSideNavWidth()

  $scope.nextPage = ->
    if !$scope.isLastPage()
      scrollToTop()
      ResultsService.nextPage()

  $scope.prevPage = ->
    if !$scope.isFirstPage()
      scrollToTop()
      ResultsService.prevPage()

  scrollToTop = ->
    $anchorScroll('search-results-wrapper')

  $scope.isFirstPage = () ->
    $scope.search_result_data.current_page == 1

  $scope.isLastPage = () ->
    total_number_of_pages = Math.ceil $scope.search_result_data.totalProviders/$scope.search_result_data.providersPerPage
    $scope.search_result_data.current_page == total_number_of_pages

  $scope.toggleMap = (provider) ->
    if provider.map
      delete provider.map
    else
      provider.map = ProviderService.providerMap(provider)

  $timeout scrollToTop()

  return

ResultsController.$inject = ['$scope', '$location', '$state', '$controller', '$anchorScroll', 'ResultsService', 'ProviderService', '$timeout']

angular
  .module('CCR')
  .component('results', {
    controller: ResultsController
    templateUrl: "results/results.html"
  })
