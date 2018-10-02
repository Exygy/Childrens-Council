FilterProgramsFilter = (DataService) ->
  (programs, filter_by) ->
    if programs and filter_by and DataService.filterData and DataService.filterData[filter_by]
      programs.filter( (value) ->
        return -1 != DataService.filterData[filter_by].indexOf(value)
      )
    else
      return []

FilterProgramsFilter.$inject = []

angular.module('CCR').filter('filterPrograms', FilterProgramsFilter)
