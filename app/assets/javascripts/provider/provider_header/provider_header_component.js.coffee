ProviderHeaderController =  ->
  return @

ProviderHeaderController.$inject = []

angular
  .module('CCR')
  .component('providerHeader', {
    bindings:
      provider: '<'
    controller: ProviderHeaderController
    templateUrl: "provider/provider_header/provider_header.html"
  })
