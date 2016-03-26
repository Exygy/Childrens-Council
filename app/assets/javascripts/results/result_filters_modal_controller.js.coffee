ResultFiltersModalController = ($scope, ResultsService, $modalInstance) ->
  $scope.filters = ResultsService.getSearchParams()
  $scope.settings = ResultsService.settings
  $scope.parent = ResultsService.parent

  $scope.reposition = () ->
    $modalInstance.reposition();

  $scope.ok = () ->
    $modalInstance.close();

  $scope.cancel = () ->
    $modalInstance.dismiss('cancel');

ResultFiltersModalController.$inject = ['$scope', 'ResultsService', '$modalInstance']
angular.module('CCR').controller('ResultFiltersModalController', ResultFiltersModalController)
