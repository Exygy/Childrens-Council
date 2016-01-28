SearchService = ($http) ->
  @parent =
    firstName: ''
    lastName: ''
    email: ''
  @results = []
  @postSearch = () ->
    $http {
      method: 'POST',
      url: '/api/search',
      data: {parent: @parent}
    }
    .then (response) ->
      # // this callback will be called asynchronously
      # // when the response is available
      console.log response.data
  @

SearchService.$inject = ['$http']
angular.module('CCR').service('SearchService', SearchService)
