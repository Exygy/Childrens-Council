ResultFilterController = ($scope, ResultsService) ->
  $scope.filters = ResultsService.getSearchParams()
  $scope.settings = ResultsService.settings

ResultFilterController.$inject = ['$scope', 'ResultsService']
angular.module('CCR').controller('ResultFilterController', ResultFilterController)
