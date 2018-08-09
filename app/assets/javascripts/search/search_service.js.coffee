SearchService = ($http, $cookies, CC_COOKIE, DataService) ->
  angular.extend SearchService.prototype, DataService

  @deleteApiKey = ->
    $cookies.remove CC_COOKIE

  @postSearch = (callback, opts = {}) ->
    if opts.deleteApiKey
      # reset API KEY == enforce parent authentication
      @deleteApiKey()

    if opts.reset
      # incase search fails - will display no results
      @resetData()

    # search
    DataService.current_page = 1
    @performSearch callback

  @

SearchService.$inject = ['$http', '$cookies', 'CC_COOKIE', 'DataService']
angular.module('CCR').service('SearchService', SearchService)
