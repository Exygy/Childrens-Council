ResultFiltersModalController = ($scope, ResultsService, $modalInstance) ->
  $scope.postSearch = ->
    ResultsService.postSearch()
    $modalInstance.close()

  $scope.cancel = ->
    $modalInstance.dismiss('cancel')

ResultFiltersModalController.$inject = ['$scope', 'ResultsService', '$modalInstance']
angular.module('CCR').controller('ResultFiltersModalController', ResultFiltersModalController)
