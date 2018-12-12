ComparePagerController = (CompareService) ->
  $ctrl = @
  $ctrl.data = CompareService.data

  $ctrl.prevPage = ->
    CompareService.prevPage()

  $ctrl.nextPage = ->
    CompareService.nextPage()

  $ctrl

ComparePagerController.$inject = ['CompareService']

angular
  .module('CCR')
  .component('comparePager', {
    controller: ComparePagerController
    bindings:
      position: '@'
    templateUrl: "compare/compare_pager/compare_pager.html"
  })
