ResultsFilterController = ($scope, $modal, ResultsService) ->
  $scope.filters = ResultsService.filters
  $scope.settings = ResultsService.searchSettings
  $scope.parent = ResultsService.parent

  $scope.$on 'search-service:updated', (event, service) ->
    $scope.filters = service.filters
    $scope.parent = service.parent
    $scope.settings = service.searchSettings

  $scope.openResultFiltersModal = () ->
    $modal.open {
      templateUrl: 'results/result_filters_modal.html'
      controller: 'ResultFiltersModalController'
    }

  $scope.openChildModal = (childId) ->
    $modal.open {
      templateUrl: 'results/child_filter_modal.html'
      controller: 'ChildModalController'
      resolve:
         childId: ->
           childId
    }

ResultsFilterController.$inject = ['$scope', '$modal', 'ResultsService']
angular.module('CCR').controller('ResultsFilterController', ResultsFilterController)
