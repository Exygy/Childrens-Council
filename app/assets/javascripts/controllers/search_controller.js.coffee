SearchController = ($scope, $state) ->
  $scope.firstName = 'Grant'
  $scope.lastName = ''
  $scope.email = ''
  $scope.zip = ''

  $scope.submitSearch = () ->
    # if(myForm.$valid) {
    $state.go('results')
    # }

SearchController.$inject = ['$scope', '$state']
angular.module('CCReferrals').controller('SearchController', SearchController)
