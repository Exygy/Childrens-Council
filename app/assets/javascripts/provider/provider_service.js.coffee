ProviderService = (SearchService, HttpService) ->
  @get = (id, callback) ->
    that = @
    HttpService.http(
      { method: 'POST', url: '/api/providers/'+id },
      (response) ->
        if callback
          filterProviders = SearchService.covid19ProvidersOnlyFilter([response.data])
          if filterProviders.length > 0
            callback(filterProviders[0])

      (error) ->
        console.log("ERROR")
        console.log(error)
    )
  return @

ProviderService.$inject = ['HttpService']
angular.module('CCR').service('ProviderService', ProviderService)
