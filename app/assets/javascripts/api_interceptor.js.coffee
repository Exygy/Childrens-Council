# is called z_api_interceptor so the file is included after ccr.js.coffee
APIInterceptor = ($location, $rootScope, $q, $cookies, CC_COOKIE) ->

  @request = (config) ->
    if config.method == "POST" || config.method == "DELETE"
      api_key = $cookies.get CC_COOKIE
      config.data = {} unless config.data
      config.data.api_key = api_key if api_key
    config

  @response = (response) ->
    api_key = response.headers('Cc-Apikey')
    $cookies.put(CC_COOKIE, api_key) if api_key
    response

  @responseError = (response) ->
    if response.status == 401 or response.status == 400
      $rootScope.$broadcast 'unauthorized'
      $location.path ""
      return response
    $q.reject response

  @

APIInterceptor.$inject = ['$location', '$rootScope', '$q', '$cookies', 'CC_COOKIE']
angular.module('CCR').service('APIInterceptor', APIInterceptor)
