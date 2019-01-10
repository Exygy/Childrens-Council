CompareProvidersHeadersController = (CompareService) ->
  $ctrl = @

  $ctrl.removeProviderFromCompare = (id) ->
    CompareService.removeProviderFromCompare(id)

  $ctrl

CompareProvidersHeadersController.$inject = ['CompareService']

angular
  .module('CCR')
  .component('compareProvidersHeaders', {
    bindings:
      providers: '<'
    controller: CompareProvidersHeadersController
    templateUrl: "compare/compare_providers_headers/compare_providers_headers.html"
  })
