angular.module('CCR')
.component 'scheduleFilter', {
  bindings:
    model: '<'
  templateUrl: 'search/components/schedule_filter.html'
  controller: ['DataService', (DataService) ->
    @days = DataService.filterData.days
    @yearlySchedules = DataService.filterData.yearlySchedules

    @
  ]
}
