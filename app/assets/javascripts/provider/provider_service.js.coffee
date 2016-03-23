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

  @providerMap = (provider) ->
    center:
      latitude: provider.latitude,
      longitude: provider.longitude
    ,
    zoom: 16,
    options:
      scrollwheel: false
      streetViewControl: false
      mapTypeControl: false

  @

ProviderService.$inject = ['HttpService']
angular.module('CCR').service('ProviderService', ProviderService)
