SearchService = ($http) ->
  Service = {}
  Service.postSearch = (parent) ->
    $http {
      method: 'POST',
      url: '/api/search',
      data: {parent: parent}
    }
    .then (response) ->
      # // this callback will be called asynchronously
      # // when the response is available
      console.log response.data

  return Service

SearchService.$inject = ['$http']
angular.module('CCR').service('SearchService', SearchService)
