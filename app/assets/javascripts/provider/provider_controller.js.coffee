ProviderController = ($scope, $state, ProviderService) ->
  $scope.provider = ProviderService.provider

ProviderController.$inject = ['$scope', '$state', 'ProviderService']
angular.module('CCR').controller('ProviderController', ProviderController)
