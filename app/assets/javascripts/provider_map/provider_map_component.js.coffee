ProviderMapController = ($timeout, $scope, NgMap, ProviderMapService, SearchService, EmailCollectorService, $element, $compile) ->
  $ctrl = @

  $scope.emailCollectorStatus = EmailCollectorService.status

  $ctrl.$onInit = ->
    setMap($ctrl.providers)
    if $ctrl.filters && !_.isEmpty($ctrl.filters.settings)
      $ctrl.searchOnDrag = $ctrl.filters.settings.searchingByMapArea

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
    $ctrl.filters && $ctrl.filters.locationA && $ctrl.filters.locationB

  $ctrl.searchingWithAddresses = ->
    $ctrl.filters.addresses && $ctrl.filters.addresses.length > 1

  $ctrl.getLocationACoords = ->
    [$ctrl.filters.locationA.latitude, $ctrl.filters.locationA.longitude]

  $ctrl.getLocationBCoords = ->
    [$ctrl.filters.locationB.latitude, $ctrl.filters.locationB.longitude]

  setMap = (providers) ->
    if providers && providers.length
      $ctrl.providers = ProviderMapService.mapify(providers)
      NgMap.getMap($ctrl.mapId).then (map) ->
        $scope.map = map
        ProviderMapService.setMap(map)
        google.maps.event.addListener($scope.map, 'dragend', ->
          redoSearchInBounds() if $ctrl.searchOnDrag
        )

  redoSearchInBounds = ->
    newBounds = $scope.map.getBounds()
    ne = newBounds.getNorthEast()
    sw = newBounds.getSouthWest()
    $ctrl.filters.settings = {} unless $ctrl.filters.settings
    $ctrl.filters.settings.searchingByMapArea = true
    $ctrl.filters.locationA = { latitude: ne.lat(), longitude: ne.lng() }
    $ctrl.filters.locationB = { latitude: sw.lat(), longitude: sw.lng() }
    $ctrl.filters.addresses = ['']
    $ctrl.filters.neighborhoods = ['']
    $ctrl.filters.zips = ['']
    SearchService.postSearch()

  $ctrl.handleMarkerMouseover = (event, providerData, map) ->
    marker = ProviderMapService.getProviderMarker({markerId: providerData.markerId})
    ProviderMapService.highlightMarker(marker, providerData.typeOfCare)
    provider = $ctrl.providers.find((p) -> p.providerId == providerData.providerId)
    provider.highlighted = true

  $ctrl.handleMarkerMouseleave = (event, providerData, map) ->
    marker = ProviderMapService.getProviderMarker({markerId: providerData.markerId})
    ProviderMapService.unHighlightMarker(marker, providerData.typeOfCare)
    provider = $ctrl.providers.find((p) -> p.providerId == providerData.providerId)
    provider.highlighted = false

  return $ctrl

ProviderMapController.$inject = ['$timeout', '$scope', 'NgMap', 'ProviderMapService', 'SearchService', 'EmailCollectorService', '$element', '$compile']

angular
  .module('CCR')
  .component('providerMap', {
    bindings:
      filters: '<'
      infoWindow: '<'
      mapId: '<'
      providers: '<'
      showSearchOnDrag: '<'
    controller: ProviderMapController
    templateUrl: "provider_map/provider_map.html"
  })
