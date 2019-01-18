CompareProvidersInfoController = (CompareService) ->
  $ctrl = @
  $ctrl.data = CompareService.data

  $ctrl

CompareProvidersInfoController.$inject = ['CompareService']

angular
  .module('CCR')
  .component('compareProvidersInfo', {
    bindings:
      providers: '<'
    controller: CompareProvidersInfoController
    templateUrl: "compare/compare_providers_info/compare_providers_info.html"
  })
