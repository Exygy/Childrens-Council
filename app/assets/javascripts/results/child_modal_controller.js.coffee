ChildModalController = ($scope, $modalInstance, ResultsService, childId) ->

  init = ->
    $scope.modal_filters =
      age_months: 30
      schedule_day_ids: [2,3,4,5,6]
      schedule_week_ids: [1]
      schedule_year_id: 1
      selected: true

    if childId?
      child = angular.copy ResultsService.parent.children_attributes[childId]

      $scope.modal_filters = ResultsService.parent.children_attributes[childId]
      $scope.modal_filters.schedule_year_id = child.schedule_year_id
      $scope.modal_filters.schedule_day_ids = []
      $scope.modal_filters.schedule_week_ids = []

      for children_schedule_days_attribute in child.children_schedule_days_attributes
        $scope.modal_filters.schedule_day_ids.push children_schedule_days_attribute.schedule_day_id

      for children_schedule_weeks_attribute in child.children_schedule_weeks_attributes
        $scope.modal_filters.schedule_week_ids.push children_schedule_weeks_attribute.schedule_week_id

  $scope.postSearch = ->
    unless childId?
      childId = ResultsService.parent.children_attributes.length

    child_obj = {}
    child_obj.age_months = $scope.modal_filters.age_months
    child_obj.schedule_year_id = $scope.modal_filters.schedule_year_id
    child_obj.children_care_types_attributes = ResultsService.parent.children_attributes[0].children_care_types_attributes
    child_obj.selected = true

    child_obj.children_schedule_days_attributes = []
    child_obj.children_schedule_weeks_attributes = []
    for schedule_day_id in $scope.modal_filters.schedule_day_ids
      child_obj.children_schedule_days_attributes.push { schedule_day_id: schedule_day_id }
    for schedule_week_id in $scope.modal_filters.schedule_week_ids
      child_obj.children_schedule_weeks_attributes.push { schedule_week_id: schedule_week_id }


    console.log "TITIT"
    console.log childId
    console.log ResultsService.parent.children_attributes[childId]
    ResultsService.updateChild(childId, child_obj)
    console.log ResultsService.parent.children_attributes[childId]

    console.log ResultsService.parent.children_attributes

    ResultsService.postSearch()
    $modalInstance.close()

  $scope.cancel = ->
    $modalInstance.dismiss('cancel')

  init()

ChildModalController.$inject = ['$scope', '$modalInstance', 'ResultsService', 'childId']
angular.module('CCR').controller('ChildModalController', ChildModalController)
