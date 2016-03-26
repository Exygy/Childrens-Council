MapController = ($scope, $q, $timeout, uiGmapIsReady) ->
    $scope.map = {center: {latitude: 37.7833, longitude: -122.4167 }, zoom: 10 };

    fitBounds = (map) ->
      bounds = new google.maps.LatLngBounds()

      for provider in $scope.data.providers
        bounds.extend new google.maps.LatLng(provider.latitude, provider.longitude)

      $timeout (->
        map.fitBounds bounds
      ), 100

    $q.all([uiGmapIsReady.promise(), $scope.data.providers.$promise]).then (datas) ->
      fitBounds datas[0][0].map

MapController.$inject = ['$scope', '$q', '$timeout', 'uiGmapIsReady']
angular.module('CCR').controller('MapController', MapController)
