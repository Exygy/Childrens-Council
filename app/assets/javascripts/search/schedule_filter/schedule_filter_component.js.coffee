ScheduleFilterController = (DataService) ->
  $ctrl = @

  $ctrl.$onInit = ->
    @days = DataService.filterData.days
    @shiftFeatures = DataService.filterData.shiftFeatures
    @yearlySchedules = DataService.filterData.yearlySchedules

  return $ctrl

ScheduleFilterController.$inject = ['DataService']

angular
  .module('CCR')
  .component('scheduleFilter', {
    bindings:
      filters: '<'
      model: '<'
    controller: ScheduleFilterController
    templateUrl: 'search/schedule_filter/schedule_filter.html'
  })
