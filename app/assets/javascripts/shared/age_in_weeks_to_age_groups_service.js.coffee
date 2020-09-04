AgeInYearToAgeGroupsService = ->
  $service = @

  $service.convert = (weeks) ->
    age_groups = []
    if weeks == 26
      age_groups.push 'INFANT_1'
    if weeks == 52
      age_groups.push 'TODDLER_1'
    if weeks == 106
      age_groups.push 'PRESCHOOL_1'
    if weeks == 160
      age_groups.push 'PRESCHOOL_1'
    if weeks == 209
      age_groups.push 'PRESCHOOL_1'
    if weeks == 260
      age_groups.push 'SCHOOL_1'
    
    age_groups.push 'SCHOOL_2'

    return age_groups

  return $service

AgeInYearToAgeGroupsService.$inject = []

angular.module('CCR').service('AgeInYearToAgeGroupsService', AgeInYearToAgeGroupsService)
