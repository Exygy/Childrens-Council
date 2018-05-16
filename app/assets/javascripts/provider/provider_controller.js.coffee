ProviderController = ($anchorScroll, $controller, $scope, $state, $timeout, ProviderService) ->
  $ctrl = @
  $controller 'ApplicationController', {$scope: $scope}

  @$onInit = () ->
    ProviderService.get $ctrl.id, (provider) ->
      $scope.provider = provider

  $timeout $anchorScroll()

  return @

ProviderController.$inject = [
  '$anchorScroll',
  '$controller',
  '$scope',
  '$state',
  '$timeout',
  'ProviderService'
]

angular
  .module('CCR')
  .component('provider', {
    bindings:
      id: '<'
    controller: ProviderController
    templateUrl: "provider/provider.html"
  })
