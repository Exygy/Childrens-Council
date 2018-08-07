GeocodingService = (NgMap) ->
  @geocodeAddress = (address) ->
    NgMap.getGeoLocation(address).then (results) ->
      return {latitude: results.lat(), longitude: results.lng()}

  @

GeocodingService.$inject = ['NgMap']
angular.module('CCR').service('GeocodingService', GeocodingService)
