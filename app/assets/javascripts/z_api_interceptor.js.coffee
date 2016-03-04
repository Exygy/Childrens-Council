APIInterceptor = ($location, $rootScope, $q, $cookies, CC_COOKIE) ->

  @request = (config) ->
    if config.method == "POST"
      api_key = $cookies.get CC_COOKIE

      console.log "api_key read", api_key

      config.data = {} unless config.data
      config.data.api_key = api_key if api_key
    config

  @response = (response) ->
    api_key = response.headers('Cc-Apikey')

    console.log 'Cc-Apikey', response.headers('Cc-Apikey')
    console.log 'cc-apikey', response.headers('cc-apikey')
    console.log 'CC-APIKEY', response.headers('CC-APIKEY')

    console.log "api_key set", api_key, response

    $cookies.put(CC_COOKIE, api_key) if api_key

    if response.status == 401 or response.status == 400
      $rootScope.$broadcast 'unauthorized'
      $location.path ""

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
