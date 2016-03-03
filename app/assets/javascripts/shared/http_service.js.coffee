HttpService = ($http, $q) ->
  @request_canceler = null

  @http = (config, callback) ->
    # cancel previous HTTP request if not completed
    @request_canceler.resolve() if @request_canceler
    @request_canceler = $q.defer()
    config.timeout = @request_canceler.promise
    # modify URL for production
    base_url = "<%= Rails.env.production? ? 'https://childrens-council.herokuapp.com/' : '' %>"
    config.url = base_url + config.url
    # trigger HTTP request
    $http(config).then (response) ->
      callback(response) if callback
  @

HttpService.$inject = ['$http', '$q']
angular.module('CCR').service('HttpService', HttpService)
