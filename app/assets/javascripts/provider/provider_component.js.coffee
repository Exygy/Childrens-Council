ProviderController = ($anchorScroll, $scope, $timeout, ProviderService) ->
  $ctrl = @

  $ctrl.$onInit = () ->
    ProviderService.get $ctrl.id, (provider) ->
      $scope.provider = provider

  $timeout $anchorScroll()

  return $ctrl

ProviderController.$inject = [
  '$anchorScroll',
  '$scope',
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
