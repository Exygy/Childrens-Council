SearchService = ($http) ->
  @data = {
    totalProviders: 0,
    providersPerPage: 25,
    providers: [],
    parent:
      firstName: ''
      lastName: ''
      email: ''
  }
  @current_page = 1

  @markers =  [
    {
      coords: {
        latitude: 40.1451,
        longitude: -99.6680
      },
      options: {},
      events: {},
      id: 123
    },
  ]

  @queryParams = ->
    { page: @current_page, per_page: @providersPerPage }

  @postSearch = (callback) ->
    that = @
    @current_page = 1
    @serverRequest (response) ->
      that.data.providers = response.data.providers
      that.data.totalProviders = response.data.total
      callback() if callback

  @nextPage = (callback) ->
    that = @
    @current_page++
    @serverRequest (response) ->
      that.data.providers = that.data.providers.concat response.data.providers
      callback() if callback

  @serverRequest = (callback) ->
    that = @
    $http {
      method: 'GET',
      url: '/api/providers',
      data: @queryParams()
    }
    .then (response) ->
      # this callback will be called asynchronously
      # when the response is available
      callback(response) if callback
  @

SearchService.$inject = ['$http']
angular.module('CCR').service('SearchService', SearchService)
