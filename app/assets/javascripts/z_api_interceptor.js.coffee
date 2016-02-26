APIInterceptor = ($location, $rootScope, $q, $cookies) ->
  @cookie_key = 'cc_api_key'

  @request = (config) ->
    if config.method == "POST"
      api_key = $cookies.get(@cookie_key)
      config.data = {} unless config.data
      config.data.api_key = api_key if api_key
    config

  @response = (response) ->
    api_key = response.headers('CC-APIKEY')
    $cookies.put(@cookie_key, api_key) if api_key
    response

  @responseError = (response) ->
    if response.status is 401 or 400
      $rootScope.$broadcast 'unauthorized'
      $location.path ""
      return response
    $q.reject response

  @

APIInterceptor.$inject = ['$location', '$rootScope', '$q', '$cookies']
angular.module('CCR').service('APIInterceptor', APIInterceptor)
