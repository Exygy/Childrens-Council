ResultListController = () ->
  $ctrl = @
  $ctrl.data

  $ctrl.$onChanges = (change) ->
    $ctrl
    console.log('change')

  $ctrl.resultsFromNum = ->
    ($ctrl.data.currentPage * $ctrl.data.pageSize) + 1

  $ctrl.resultsToNum = ->
    ($ctrl.data.currentPage + 1) * $ctrl.data.pageSize

  return $ctrl

angular
  .module('CCR')
  .component('resultList', {
    bindings:
      data: '<'
    controller: ResultListController
    templateUrl: "results/result_list/result_list.html"
  })
