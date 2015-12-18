ResultsController = ($scope) ->
  $scope.results = 'Results'

ResultsController.$inject = ['$scope']
angular.module('CCReferrals').controller('ResultsController', ResultsController)
