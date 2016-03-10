ProviderService = (HttpService) ->
  @provider = {}

  @results = []
  @getProvider = (id) ->
    that = @
    HttpService.http(
      {
        method: 'POST',
        url: '/api/providers/'+id
      },
      (response) ->
        # // this callback will be called asynchronously
        # // when the response is available
        that.provider = response.data.provider
    )
  @

ProviderService.$inject = ['HttpService']
angular.module('CCR').service('ProviderService', ProviderService)
