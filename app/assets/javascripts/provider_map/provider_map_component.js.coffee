ProviderMapController = ($timeout, $scope, NgMap, ProviderMapService) ->
  $ctrl = @
  $scope.providers = []

  @$onInit = ->
    setMap($ctrl.providers)

  @$onChanges = (obj) ->
    setMap(obj.providers.currentValue)

  setMap = (providers) ->
    if providers.length
      $scope.providers = ProviderMapService.mapify(providers)
      if $scope.map
        fitBounds($scope.map)
      else
        NgMap.getMap().then (map) ->
          $scope.map = map
          fitBounds(map)

  fitBounds = (map) ->
    bounds = new google.maps.LatLngBounds()
    if $scope.providers.length
      for provider in $scope.providers
        bounds.extend new google.maps.LatLng(
          provider.position.split(',')[0],
          provider.position.split(',')[1]
        )
      $timeout (->
        $scope.map.fitBounds(bounds)
      ), 10

  return @

ProviderMapController.$inject = ['$timeout', '$scope', 'NgMap', 'ProviderMapService']

angular
  .module('CCR')
  .component('providerMap', {
    bindings:
      infoWindow: '<',
      providers: '<'
    controller: ProviderMapController
    templateUrl: "provider_map/provider_map.html"
  })
