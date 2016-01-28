SearchService = ($http) ->
  @parent =
    firstName: ''
    lastName: ''
    email: ''
  @results = []

  @markers =  [
    {
      coords: {
        latitude: 40.1451,
        longitude: -99.6680
      },
      options: {},
      events: {},
      id: 123
    }
  ]


  @postSearch = (callback) ->
    that = @
    $http {
      method: 'POST',
      url: '/api/search',
      data: {parent: @parent}
    }
    .then (response) ->
      # // this callback will be called asynchronously
      # // when the response is available
      that.parent = response.data
      that.results = [1]
      if callback
        callback()
  @

SearchService.$inject = ['$http']
angular.module('CCR').service('SearchService', SearchService)
