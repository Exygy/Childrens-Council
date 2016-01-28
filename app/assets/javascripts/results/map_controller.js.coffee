MapController = ($scope, SearchService, $log) ->
    $scope.map = {center: {latitude: 40.1451, longitude: -99.6680 }, zoom: 8 };
    $scope.markers = SearchService.markers

MapController.$inject = ['$scope', 'SearchService', '$log']
angular.module('CCR').controller('MapController', MapController)
