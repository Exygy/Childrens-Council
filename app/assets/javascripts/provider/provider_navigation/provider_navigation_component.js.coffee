ProviderNavigationController =  ->
  return @

ProviderNavigationController.$inject = []

angular
  .module('CCR')
  .component('providerNavigation', {
    bindings:
      provider: '<'
    controller: ProviderNavigationController
    templateUrl: "/assets/provider/provider_navigation/provider_navigation.html"
  })
