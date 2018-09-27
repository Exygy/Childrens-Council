AgeInWeekToAgeGroupsService = ->
  $service = @

  $service.convert = (weeks) ->
    age_groups = []
    # 0 yrs to 1 yr 11 mos
    if weeks < 102
      age_groups.push 'INFANT_1'
    # 18 to 36 Months
    if weeks >= 78 && weeks < 157
      age_groups.push 'TODDLER_1'
    # 2 yrs to 5 yrs 11 mos
    if weeks >= 102 && weeks < 312
      age_groups.push 'PRESCHOOL_1'
    # 6 yrs and up
    if weeks >= 312
      age_groups.push 'SCHOOL_1'
    # "SCHOOL_2" represents all ages
    age_groups.push 'SCHOOL_2'

    return age_groups

  return $service

AgeInWeekToAgeGroupsService.$inject = []

angular.module('CCR').service('AgeInWeekToAgeGroupsService', AgeInWeekToAgeGroupsService)
