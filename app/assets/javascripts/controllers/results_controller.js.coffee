ResultsController = ($scope) ->
  $scope.results = 'Results'

ResultsController.$inject = ['$scope']
angular.module('CCR').controller('ResultsController', ResultsController)
