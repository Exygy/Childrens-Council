ProviderService = (HttpService) ->
  @get = (id, callback) ->
    that = @
    HttpService.http(
      { method: 'POST', url: '/api/providers/'+id },
      (response) ->
        if callback
          callback(response.data)

      (error) ->
        console.log("ERROR")
        console.log(error)
    )
  return @

ProviderService.$inject = ['HttpService']
angular.module('CCR').service('ProviderService', ProviderService)
