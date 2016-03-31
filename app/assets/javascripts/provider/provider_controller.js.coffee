ProviderController = ($scope, $state, $controller, ProviderService) ->
  $controller 'ApplicationController', {$scope: $scope}
  $scope.provider = ProviderService.provider
  $scope.provider.map = ProviderService.providerMap($scope.provider)

ProviderController.$inject = ['$scope', '$state', '$controller', 'ProviderService']
angular.module('CCR').controller('ProviderController', ProviderController)
