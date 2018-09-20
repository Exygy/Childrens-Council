ShiftNameToDescriptionFilter = (DataService) ->
  (shift_name) ->
    for shiftFeature in DataService.filterData.shiftFeatures
      if shiftFeature.name == shift_name
        return shiftFeature.description
    return false

ShiftNameToDescriptionFilter.$inject = ['DataService']

angular.module('CCR').filter('shiftNameToDescription', ShiftNameToDescriptionFilter)
