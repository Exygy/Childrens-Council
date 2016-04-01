ProviderController = ($scope, $state, $controller, $anchorScroll, ProviderService) ->
  $controller 'ApplicationController', {$scope: $scope}
  $scope.provider = ProviderService.provider
  $scope.provider.map = ProviderService.providerMap($scope.provider)

  scrollToTop = ->
    $anchorScroll('provider-content-wrapper')

  scrollToTop()

ProviderController.$inject = ['$scope', '$state', '$controller', '$anchorScroll', 'ProviderService']
angular.module('CCR').controller('ProviderController', ProviderController)
