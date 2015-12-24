SearchController = ($scope, $state, SearchService) ->
  $scope.parent =
    firstName: ''
    lastName: ''
    email: ''

  $scope.submitSearch = () ->
    SearchService.postSearch($scope.parent)
    # $state.go('results')

SearchController.$inject = ['$scope', '$state', 'SearchService']
angular.module('CCReferrals').controller('SearchController', SearchController)
