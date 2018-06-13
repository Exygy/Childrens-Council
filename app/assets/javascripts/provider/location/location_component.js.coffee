LocationController = ($scope, NgMap, LocationService) ->
  $ctrl = @

  $scope.googleMapsUrl="//maps.googleapis.com/maps/api/js?key=AIzaSyBEDS_ZhrTUaoj4x5YdIv5rhKVf8LmGz7I"

  @$onInit = () ->
    $ctrl.provider = LocationService.mapify($ctrl.provider)

    NgMap.getMap().then (map) ->
      $ctrl.map = map

    return

  return @

LocationController.$inject = ['$scope', 'NgMap', 'LocationService']

angular
  .module('CCR')
  .component('location', {
    bindings:
      provider: '<'
    controller: LocationController
    templateUrl: "provider/location/location.html"
  })
