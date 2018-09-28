ScheduleYearValueToLabelFilter = (DataService) ->
  (value) ->
    sched = DataService.filterData.yearlySchedules.find((sched) -> sched.value == value)
    sched.label if sched

ScheduleYearValueToLabelFilter.$inject = ['DataService']

angular.module('CCR').filter('scheduleYearValueToLabel', ScheduleYearValueToLabelFilter)
