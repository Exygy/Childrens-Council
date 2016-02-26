ResultsService = ($http, DataService) ->
  angular.extend ResultsService.prototype, DataService

  @nextPage = (callback) ->
    @current_page++
    @performSearch callback

  @prevPage = (callback) ->
    @current_page--
    @performSearch callback

  @

ResultsService.$inject = ['$http', 'DataService']
angular.module('CCR').service('ResultsService', ResultsService)
