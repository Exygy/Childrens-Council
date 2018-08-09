GeocodingService = (NgMap) ->
  @geocodeAddress = (address) ->
    NgMap.getGeoLocation(address).then (results) ->
      # TODO: add error handling
      return {latitude: results.lat(), longitude: results.lng()}

  @

GeocodingService.$inject = ['NgMap']
angular.module('CCR').service('GeocodingService', GeocodingService)
