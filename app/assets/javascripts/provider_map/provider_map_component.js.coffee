ProviderMapController = ($timeout, $scope, NgMap, ProviderMapService, SearchService, $element, $compile) ->
  $ctrl = @

  $ctrl.searchOnDrag = false

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
    # Needs timeout to process infowindow actions
    $timeout(
      ->
        temp = $compile('<provider-map-item provider="$ctrl.provider"></provider-map-item>')($scope)
        angular.element(document.getElementById('providerContent')).append(temp)
      , 200)

  $ctrl.searchingBtwnTwoPoints = ->
    $ctrl.filters.locationA && $ctrl.filters.locationB

  $ctrl.searchingWithAddresses = ->
    $ctrl.filters.addresses && $ctrl.filters.addresses.length > 1

  $ctrl.getLocationACoords = ->
    [$ctrl.filters.locationA.latitude, $ctrl.filters.locationA.longitude]

  $ctrl.getLocationBCoords = ->
    [$ctrl.filters.locationB.latitude, $ctrl.filters.locationB.longitude]

  setMap = (providers) ->
    if providers.length
      $ctrl.providers = ProviderMapService.mapify(providers)
      NgMap.getMap($ctrl.mapId).then (map) ->
        $scope.map = map
        google.maps.event.addListener($scope.map, 'dragend', ->
          redoSearchInBounds() if $ctrl.searchOnDrag
        )

  redoSearchInBounds = ->
    newBounds = $scope.map.getBounds()
    ne = newBounds.getNorthEast()
    sw = newBounds.getSouthWest()
    $ctrl.filters.locationA = { latitude: ne.lat(), longitude: ne.lng() }
    $ctrl.filters.locationB = { latitude: sw.lat(), longitude: sw.lng() }
    $ctrl.filters.addresses = ['']
    SearchService.postSearch()

  return $ctrl

ProviderMapController.$inject = ['$timeout', '$scope', 'NgMap', 'ProviderMapService', 'SearchService', '$element', '$compile']

angular
  .module('CCR')
  .component('providerMap', {
    bindings:
      infoWindow: '<',
      mapId: '<'
      providers: '<'
      filters: '<'
    controller: ProviderMapController
    templateUrl: "provider_map/provider_map.html"
  })
