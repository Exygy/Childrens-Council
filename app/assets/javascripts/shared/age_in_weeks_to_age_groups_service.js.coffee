AgeInYearToAgeGroupsService = ->
  $service = @

  $service.convert = (year) ->
    age_groups = []
    # 0 yrs to 1 yr 11 mos
    if year == 'less_than_1_year_old'
      age_groups.push 'INFANT_1'
    # 18 to 36 Months
    if year == '1_year_old'
      age_groups.push 'TODDLER_1'
    # 2 yrs to 5 yrs 11 mos
    if year == '2_year_old'
      age_groups.push 'PRESCHOOL_1'
    if year == '3_year_old'
      age_groups.push 'PRESCHOOL_1'
    if year == '4_year_old'
      age_groups.push 'PRESCHOOL_1'
    # 5 yrs and up
    if year == '5_year_old_or_holder'
      age_groups.push 'SCHOOL_1'
    # "SCHOOL_2" represents all ages
    age_groups.push 'SCHOOL_2'

    return age_groups

  return $service

AgeInYearToAgeGroupsService.$inject = []

angular.module('CCR').service('AgeInYearToAgeGroupsService', AgeInYearToAgeGroupsService)
