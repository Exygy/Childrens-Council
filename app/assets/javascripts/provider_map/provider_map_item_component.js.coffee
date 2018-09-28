ProviderMapItemController = ($scope) ->
  $ctrl = @

  return $ctrl

ProviderMapItemController.$inject = ['$scope']

angular
  .module('CCR')
  .component('providerMapItem', {
    bindings:
      provider: '<'
    controller: ProviderMapItemController
    templateUrl: "provider_map/provider_map_item.html"
  })
