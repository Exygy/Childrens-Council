ResultsController = ($scope, SearchService) ->
  $scope.results = SearchService.results

ResultsController.$inject = ['$scope', 'SearchService']
angular.module('CCR').controller('ResultsController', ResultsController)
