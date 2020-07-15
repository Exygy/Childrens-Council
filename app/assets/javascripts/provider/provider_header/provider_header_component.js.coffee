ProviderHeaderController = ($scope, SearchService) ->
  $ctrl = @

  $ctrl.providerName = (provider) ->
    name = provider.centerName
    if !name
      if provider.primaryOwner
        name = "#{provider.primaryOwner.firstName} #{provider.primaryOwner.lastName}"
      else
        name = "Name Unknown"
    name

  
  $ctrl.$onInit = () ->
    filterProviders = SearchService.covid19ProvidersOnlyFilter([$ctrl.provider])
    $scope.providerIsOpenDuringCovd19 = filterProviders.length > 0

  return $ctrl

ProviderHeaderController.$inject = ['$scope', 'SearchService']

angular
  .module('CCR')
  .component('providerHeader', {
    bindings:
      provider: '<'
      search: '<'

    controller: ProviderHeaderController
    templateUrl: "provider/provider_header/provider_header.html"
  })
