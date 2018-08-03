angular.module('CCR')
.component 'scheduleFilter', {
  bindings:
    model: '<'
  templateUrl: 'search/components/schedule-filter.html'
  controller: ['DataService', (DataService) ->
    @yearlySchedules = DataService.filterData.yearlySchedules

    @
  ]
}
