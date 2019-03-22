ResultsNameFilterBarController = ($scope, ResultsService) ->
  $ctrl = @

  $ctrl.$onInit = ->
    $ctrl.searchedName = $ctrl.filters.name

  $ctrl.$onChanges = (changesObj) ->
    if _.has(changesObj, 'providers')
      $ctrl.searchedName = $ctrl.filters.name

  $ctrl

ResultsNameFilterBarController.$inject = ['$scope', 'ResultsService']
angular.module('CCR').component('resultsNameFilterBar',
  bindings:
    filters: '<'
    postSearch: '&'
    providers: '<'
  controller: ResultsNameFilterBarController
  templateUrl: 'results/components/results_name_filter_bar/results_name_filter_bar.html'
)
