ResultMapController = ($scope, ResultsService) ->
  $ctrl = @

  $scope.filters = ResultsService.filters

  $scope.$on 'search-service:updated', (event, service) ->
    $scope.filters = service.filters

ResultMapController.$inject = ['$scope', 'ResultsService']

angular
  .module('CCR')
  .component('resultMap', {
    bindings:
      data: '<'
      showSearchOnDrag: '<'
    controller: ResultMapController
    templateUrl: "results/components/result_map/result_map.html"
  })
