ResultListController = ($scope, $modal, CompareService, ResultsService) ->
  $ctrl = @
  $ctrl.providerIdsToCompare = CompareService.data.providerIds

  $scope.filters = ResultsService.filters

  $scope.$on 'search-service:updated', (event, service) ->
    $scope.filters = service.filters

  $scope.openResultFiltersModal = () ->
    $modal.open {
      templateUrl: 'results/result_filters_modal.html'
      controller: 'ResultFiltersModalController'
    }

  return $ctrl

ResultListController.$inject = ['$scope', '$modal', 'CompareService', 'ResultsService']

angular
  .module('CCR')
  .component('resultList', {
    bindings:
      data: '<'
    controller: ResultListController
    templateUrl: "results/result_list/result_list.html"
  })
