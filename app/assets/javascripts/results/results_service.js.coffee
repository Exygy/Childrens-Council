ResultsService = (DataService, SearchService) ->
  $service = @
  $service.filterData = DataService.filterData
  $service.filters = DataService.filters
  $service.parent = DataService.parent
  $service.searchSettings = DataService.searchSettings
  $service.searchResultsData = DataService.searchResultsData

  $service.nextPage = (callback) ->
    SearchService.performSearch callback, ($service.searchResultsData.currentPage + 1)

  $service.prevPage = (callback) ->
    SearchService.performSearch callback, ($service.searchResultsData.currentPage - 1)

  $service

ResultsService.$inject = ['DataService', 'SearchService']
angular.module('CCR').service('ResultsService', ResultsService)
