ProviderNavigationController =  ->
  return @

ProviderNavigationController.$inject = []

angular
  .module('CCR')
  .component('providerNavigation', {
    bindings:
      provider: '<'
    controller: ProviderNavigationController
    templateUrl: "provider/provider_navigation/provider_navigation.html"
  })
