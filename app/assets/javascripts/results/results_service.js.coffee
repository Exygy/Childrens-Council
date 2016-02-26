ResultsService = ($http, DataService) ->
  angular.extend ResultsService.prototype, DataService

  @nextPage = (callback) ->
    DataService.current_page++
    DataService.performSearch callback

  @prevPage = (callback) ->
    DataService.current_page--
    DataService.performSearch callback

  @

ResultsService.$inject = ['$http', 'DataService']
angular.module('CCR').service('ResultsService', ResultsService)
