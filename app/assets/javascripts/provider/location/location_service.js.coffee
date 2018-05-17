LocationService = () ->
  @mapify = (provider) ->
    for address in provider.addresses
      if address.type == "Physical Address" and address.status == "Active"
        provider.address = address
        provider.map = @map(address.latitude, address.longitude)
    return provider

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

LocationService.$inject = []
angular.module('CCR').service('LocationService', LocationService)
