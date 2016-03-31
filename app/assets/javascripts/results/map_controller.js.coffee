MapController = ($scope, $q, $timeout, uiGmapIsReady) ->
    $scope.map = {
      center:
        latitude: 37.7833
        longitude: -122.4167
      zoom: 10
      control: {}
      windows_control: {}
    }

    fitBounds = (map) ->
      bounds = new google.maps.LatLngBounds()
      for provider in $scope.search_result_data.providers
        bounds.extend new google.maps.LatLng(provider.latitude, provider.longitude)
      $timeout (->
        map.fitBounds bounds
      ), 100

    uiGmapIsReady.promise(1).then (instances) ->
      for inst in instances
          map = inst.map
          fitBounds map

    $scope.$watch 'search_result_data.providers', () ->
      map = $scope.map.control.getGMap()
      fitBounds map


MapController.$inject = ['$scope', '$q', '$timeout', 'uiGmapIsReady']
angular.module('CCR').controller('MapController', MapController)
