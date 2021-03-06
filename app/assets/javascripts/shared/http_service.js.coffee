HttpService = ($http, $q) ->
  @retry = true
  @request_canceler = null

  @http = (config, callback) ->
    # cancel previous HTTP request if not completed
    @request_canceler.resolve() if @request_canceler
    @request_canceler = $q.defer()
    config.timeout = @request_canceler.promise
    # modify URL for production
    base_url = CCR_ENV['RAILS_API_URL']
    config.url = base_url + config.url

    successCallback = (response) ->
      callback(response) if callback

    errorCallback = (response) ->
      status = response.status
      if status == 503
        if @retry
          $http(config).then(successCallback, errorCallback)
          @retry = false
        else
          @retry = true
          window.location = 'http://www.childrenscouncil.org/families/find-child-care/child-care-referrals/child-care-search/'

    # trigger HTTP request
    $http(config).then(successCallback, errorCallback)
  @

HttpService.$inject = ['$http', '$q']
angular.module('CCR').service('HttpService', HttpService)
