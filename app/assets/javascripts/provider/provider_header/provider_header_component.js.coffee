ProviderHeaderController =  ->
  $ctrl = @

  $ctrl.providerName = (provider) ->
    name = provider.centerName
    if !name
      if provider.primaryOwner
        name = "#{provider.primaryOwner.firstName} #{provider.primaryOwner.lastName}"
      else
        name = "Name Unknown"
    name


  return $ctrl

ProviderHeaderController.$inject = []

angular
  .module('CCR')
  .component('providerHeader', {
    bindings:
      provider: '<'
      search: '<'

    controller: ProviderHeaderController
    templateUrl: "provider/provider_header/provider_header.html"
  })
