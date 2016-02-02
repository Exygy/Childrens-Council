MapController = ($scope) ->
    $scope.map = {center: {latitude: 37.7833, longitude: -122.4167 }, zoom: 10 };

MapController.$inject = ['$scope']
angular.module('CCR').controller('MapController', MapController)
