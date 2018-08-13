angular.module('CCR')
.component 'scheduleFilter', {
  bindings:
    model: '<'
  templateUrl: 'search/filters/schedule_filter.html'
  controller: ['DataService', (DataService) ->
    @days = DataService.filterData.days
    @yearlySchedules = DataService.filterData.yearlySchedules

    @
  ]
}
