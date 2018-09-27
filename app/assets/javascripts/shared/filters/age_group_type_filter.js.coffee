AgeGroupTypeFilter = ->
  (age_group_type) ->
    age_group_type_mapping =
      "2yrs., 0mos. to 5yrs., 11mos.": "2yrs. to 5yrs., 11mos.",
      "*FCC* All Ages": "Birth to 13yrs"

    if age_group_type_mapping[age_group_type]
      return age_group_type_mapping[age_group_type]
    else
      return age_group_type

AgeGroupTypeFilter.$inject = []

angular.module('CCR').filter('friendlyAgeGroupType', AgeGroupTypeFilter)
