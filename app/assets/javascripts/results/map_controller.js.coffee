MapController = ($scope, $q, $timeout, $location, $state, uiGmapIsReady, ResultsService) ->
    $scope.map = {
      center:
        latitude: 37.7833
        longitude: -122.4167
      zoom: 10
      control: {}
      windows_control: {}
      options:
        disableDefaultUI: true
        zoomControl: true
        zoomControlOptions:
            position: google.maps.ControlPosition.TOP_LEFT
    }

    fitBounds = (map) ->
      bounds = new google.maps.LatLngBounds()
      if $scope.search_result_data.providers.length
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


MapController.$inject = ['$scope', '$q', '$timeout', '$location', '$state', 'uiGmapIsReady', 'ResultsService']
angular.module('CCR').controller('MapController', MapController)
