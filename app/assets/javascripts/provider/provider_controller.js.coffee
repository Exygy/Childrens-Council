ProviderController = ($scope, $state, ProviderService) ->
  $scope.provider = ProviderService.provider
  $scope.provider.map = ProviderService.providerMap($scope.provider)

ProviderController.$inject = ['$scope', '$state', 'ProviderService']
angular.module('CCR').controller('ProviderController', ProviderController)
