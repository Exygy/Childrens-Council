ProviderService = (HttpService) ->
  @get = (id, callback) ->
    that = @
    HttpService.http(
      {
        method: 'POST',
        url: '/api/providers/'+id
      },
      (response) ->
        # // this callback will be called asynchronously
        # // when the response is available
        provider = response.data

        for address in provider.addresses
          if address.type == "Physical Address" and address.status == "Active"
            provider.address = address
            provider.map = that.map(address.latitude, address.longitude)

        if callback
          callback(provider)

      (error) ->
        console.log("ERROR")
        console.log(error)
    )

  @map = (latitude, longitude) ->
    center:
      latitude: latitude,
      longitude: longitude
    ,
    zoom: 16,
    options:
      scrollwheel: false
      streetViewControl: false
      mapTypeControl: false

  @

ProviderService.$inject = ['HttpService']
angular.module('CCR').service('ProviderService', ProviderService)
