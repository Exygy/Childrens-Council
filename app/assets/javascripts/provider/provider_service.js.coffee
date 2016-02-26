ProviderService = ($http) ->
  @provider = {}

  @results = []
  @getProvider = (id) ->
    that = @
    $http {
      method: 'POST',
      url: '/api/providers/'+id
    }
    .then (response) ->
      # // this callback will be called asynchronously
      # // when the response is available
      that.provider = response.data
  @

ProviderService.$inject = ['$http']
angular.module('CCR').service('ProviderService', ProviderService)
