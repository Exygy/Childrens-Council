ResultListController = ($scope, $modal, CompareService, ResultsService) ->
  $ctrl = @
  $ctrl.providerIdsToCompare = CompareService.data.providerIds

  $scope.filters = ResultsService.filters

  $scope.$on 'search-service:updated', (event, service) ->
    $scope.filters = service.filters

  $scope.openResultFiltersModal = () ->
    $modal.open {
      templateUrl: 'results/modals/result_filters_modal.html'
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
    templateUrl: "results/components/result_list/result_list.html"
  })
