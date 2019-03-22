ResultsFilterController = ($scope, $modal, ResultsService) ->
  $ctrl = @

  $ctrl.$onInit = ->
    updateDataFromService(ResultsService)

  $scope.$on 'search-service:updated', (event, service) ->
    updateDataFromService(service)

  $scope.$on 'results-service:updated', (event, service) ->
    updateDataFromService(service)

  updateDataFromService = (service) ->
    $scope.filters = service.filters
    $scope.parent = service.parent
    $scope.settings = service.searchSettings

  $scope.openResultFiltersModal = () ->
    $modal.open {
      templateUrl: 'results/modals/result_filters_modal.html'
      controller: 'ResultFiltersModalController'
    }

  $scope.openChildModal = (childId) ->
    $modal.open {
      templateUrl: 'results/modals/child_filter_modal.html'
      controller: 'ChildModalController'
      resolve:
         childId: ->
           childId
    }

  $ctrl

ResultsFilterController.$inject = ['$scope', '$modal', 'ResultsService']
angular.module('CCR').controller('ResultsFilterController', ResultsFilterController)
