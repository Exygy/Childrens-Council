FilterProgramsFilter = (DataService) ->
  (programs, filter_by) ->
    if DataService.filterData[filter_by] and programs
      programs.filter( (value) ->
        return -1 != DataService.filterData[filter_by].indexOf(value)
      )
    else
      return []
angular.module('CCR').filter('filterPrograms', FilterProgramsFilter)
