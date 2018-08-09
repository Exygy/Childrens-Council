ResultsFilterController = ($scope, $modal, ResultsService, SearchService) ->
  $scope.filters = SearchService.filters
  $scope.settings = SearchService.settings
  $scope.parent = ResultsService.parent
  $scope.settings.show_more_filters = false

  $scope.openResultFiltersModal = () ->
    $modal.open {
      templateUrl: 'results/result_filters_modal.html'
      controller: 'ResultFiltersModalController'
    }

  $scope.openChildModal = (child_id) ->
    $modal.open {
      templateUrl: 'results/child_filter_modal.html'
      controller: 'ChildModalController'
      resolve:
         childId: ->
           child_id
    }

ResultsFilterController.$inject = ['$scope', '$modal', 'ResultsService', 'SearchService']
angular.module('CCR').controller('ResultsFilterController', ResultsFilterController)
