ResultsService = ($rootScope, DataService, SearchService) ->
  $service = @
  $service.covid19ProvidersOnly = DataService.covid19ProvidersOnly
  $service.filterData = DataService.filterData
  $service.filters = DataService.filters
  $service.parent = DataService.parent
  $service.searchSettings = DataService.searchSettings
  $service.searchResultsData = DataService.searchResultsData

  $rootScope.$on 'data-service:updated', (event, service) ->
    $service.filters = service.filters
    $service.parent = service.parent
    $service.searchSettings = service.searchSettings
    $rootScope.$broadcast('results-service:updated', $service)

  $service.nextPage = (callback) ->
    SearchService.performSearch callback, ($service.searchResultsData.currentPage + 1)

  $service.prevPage = (callback) ->
    SearchService.performSearch callback, ($service.searchResultsData.currentPage - 1)

  $service

ResultsService.$inject = ['$rootScope', 'DataService', 'SearchService']
angular.module('CCR').service('ResultsService', ResultsService)
