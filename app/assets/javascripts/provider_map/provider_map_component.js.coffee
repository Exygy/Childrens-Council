ProviderMapController = ($timeout, $scope, NgMap, ProviderMapService, $element, $compile) ->
  $ctrl = @

  $ctrl.$onInit = ->
    setMap($ctrl.providers)

  $ctrl.$onChanges = (obj) ->
    setMap(obj.providers.currentValue)

  $ctrl.openInfoWindow = (event, provider, map) ->
    $ctrl.provider = provider
    if $ctrl.infowindow
      $ctrl.infowindow.close()
    $ctrl.infowindow = new google.maps.InfoWindow()
    center = new google.maps.LatLng(event.latLng.lat(), event.latLng.lng())

    $('#providerContent').remove()
    $ctrl.infowindow.setContent("<div id='providerContent'></div>");
    $ctrl.infowindow.setPosition(center);
    $ctrl.infowindow.open(map);
#   Needs timeout to process infowindow actions
    $timeout(
      ->
        temp = $compile('<provider-map-item provider="$ctrl.provider"></provider-map-item>')($scope)
        angular.element(document.getElementById('providerContent')).append(temp)
      , 200)

  setMap = (providers) ->
    if providers.length
      $ctrl.providers = ProviderMapService.mapify(providers)
      if $scope.map
        fitBounds($scope.map)
      else
        NgMap.getMap().then (map) ->
          $scope.map = map
          fitBounds(map)

  fitBounds = (map) ->
    bounds = new google.maps.LatLngBounds()
    if $ctrl.providers.length
      for provider in $ctrl.providers
        bounds.extend new google.maps.LatLng(
          provider.position.split(',')[0],
          provider.position.split(',')[1]
        )
      $timeout (->
        $scope.map.fitBounds(bounds)
      ), 10

  return $ctrl

ProviderMapController.$inject = ['$timeout', '$scope', 'NgMap', 'ProviderMapService', '$element', '$compile']

angular
  .module('CCR')
  .component('providerMap', {
    bindings:
      infoWindow: '<',
      providers: '<'
    controller: ProviderMapController
    templateUrl: "provider_map/provider_map.html"
  })
