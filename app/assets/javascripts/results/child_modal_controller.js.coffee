ChildModalController = ($scope, $modalInstance, ResultsService, childId) ->
  init = ->
    $scope.is_editing = childId?
    $scope.modal_filters =
      age_months: 30
      children_care_types_attributes: ResultsService.parent.children_attributes[0].children_care_types_attributes
      schedule_day_ids: [2,3,4,5,6]
      schedule_week_ids: [1]
      schedule_year_id: 1
      selected: true

    if childId?
      child = angular.copy ResultsService.parent.children_attributes[childId]
      $scope.modal_filters = child

      $scope.modal_filters.schedule_day_ids = []
      for children_schedule_days_attribute in child.children_schedule_days_attributes
        $scope.modal_filters.schedule_day_ids.push children_schedule_days_attribute.schedule_day_id

      $scope.modal_filters.schedule_week_ids = []
      for children_schedule_weeks_attribute in child.children_schedule_weeks_attributes
        $scope.modal_filters.schedule_week_ids.push children_schedule_weeks_attribute.schedule_week_id

  $scope.postSearch = ->
    unless childId?
      childId = ResultsService.parent.children_attributes.length
    ResultsService.parent.children_attributes[childId] = $scope.modal_filters
    ResultsService.postSearch()
    $modalInstance.close()

  $scope.cancel = ->
    $modalInstance.dismiss('cancel')

  init()

ChildModalController.$inject = ['$scope', '$modalInstance', 'ResultsService', 'childId']
angular.module('CCR').controller('ChildModalController', ChildModalController)
