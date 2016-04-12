ProviderController = ($scope, $state, $controller, $anchorScroll, ProviderService, $timeout) ->
  $controller 'ApplicationController', {$scope: $scope}
  $scope.provider = ProviderService.provider
  $scope.provider.map = ProviderService.providerMap($scope.provider)

  $timeout $anchorScroll()

ProviderController.$inject = ['$scope', '$state', '$controller', '$anchorScroll', 'ProviderService', '$timeout']
angular.module('CCR').controller('ProviderController', ProviderController)
