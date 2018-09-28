ResultsShowingController = () ->
  $ctrl = @
  $ctrl.data

  $ctrl.resultsFromNum = ->
    if $ctrl.data.totalNumProviders == 0
      0
    else
      ($ctrl.data.currentPage * $ctrl.data.pageSize) + 1

  $ctrl.resultsToNum = ->
    if $ctrl.data.totalNumProviders > $ctrl.data.pageSize
      ($ctrl.data.currentPage + 1) * $ctrl.data.pageSize
    else
      $ctrl.data.totalNumProviders
  return $ctrl

angular
  .module('CCR')
  .component('resultsShowing', {
  bindings:
    data: '<'
  controller: ResultsShowingController
  templateUrl: "results/results_showing.html"
})
