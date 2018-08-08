ChildModalController = ($scope, $modalInstance, ResultsService, childId) ->
  init = ->
    $scope.is_editing = childId?
    $scope.modal_filters =
      age_weeks: 130
      children_care_types: ResultsService.parent.children[0].children_care_types
      weeklySchedule: [2,3,4,5,6]
      schedule_week_ids: [1]
      yearlySchedule: 'FULL_YEAR'
      selected: true

    if childId?
      child = angular.copy ResultsService.parent.children[childId]
      $scope.modal_filters = child

  $scope.postSearch = ->
    unless childId?
      childId = ResultsService.parent.children.length
    ResultsService.parent.children[childId] = $scope.modal_filters
    SearchService.postSearch()
    $modalInstance.close()

  $scope.cancel = ->
    $modalInstance.dismiss('cancel')

  init()

ChildModalController.$inject = ['$scope', '$modalInstance', 'ResultsService', 'childId']
angular.module('CCR').controller('ChildModalController', ChildModalController)
