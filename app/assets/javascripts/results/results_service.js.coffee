ResultsService = ($http, DataService) ->
  angular.extend ResultsService.prototype, DataService

  @search = (params, callback) ->
    @filters = params
    @performSearch callback

  @nextPage = (callback) ->
    DataService.current_page++
    DataService.performSearch callback

  @prevPage = (callback) ->
    DataService.current_page--
    DataService.performSearch callback

  @

ResultsService.$inject = ['$http', 'DataService']
angular.module('CCR').service('ResultsService', ResultsService)
