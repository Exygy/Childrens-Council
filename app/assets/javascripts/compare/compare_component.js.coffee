CompareController = (CompareService) ->
  $ctrl = @
  $ctrl.isLoading = true
  $ctrl.data = CompareService.data
  $ctrl.pageSize = CompareService.pageSize

  $ctrl.$onInit = ->
    CompareService.fetchProviders(->
      $ctrl.isLoading = false
    )

  $ctrl.showMoreDetails = ->
    CompareService.showMoreDetails()

  $ctrl

CompareController.$inject = ['CompareService']

angular.module('CCR').controller('CompareController', CompareController)

angular
  .module('CCR')
  .component('compare', {
    bindings:
      token: '<'
    controller: CompareController
    templateUrl: "compare/compare.html"
  })
