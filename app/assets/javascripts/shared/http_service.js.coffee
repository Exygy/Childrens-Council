HttpService = ($http, $q) ->
  @request_canceler = null

  @http = (config, callback) ->
    @request_canceler.resolve() if @request_canceler
    @request_canceler = $q.defer()
    config.timeout = @request_canceler.promise
    $http(config).then (response) ->
      callback(response) if callback

  @

HttpService.$inject = ['$http', '$q']
angular.module('CCR').service('HttpService', HttpService)
