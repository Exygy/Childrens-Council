ResultsService = (DataService, SearchService) ->
  @filterData = DataService.filterData
  @filters = DataService.filters
  @parent = DataService.parent
  @searchSettings = DataService.searchSettings
  @searchResultsData = DataService.searchResultsData

  @nextPage = (callback) ->
    SearchService.performSearch callback, (@searchResultsData.currentPage + 1)

  @prevPage = (callback) ->
    SearchService.performSearch callback, (@searchResultsData.currentPage - 1)

  @

ResultsService.$inject = ['DataService', 'SearchService']
angular.module('CCR').service('ResultsService', ResultsService)
