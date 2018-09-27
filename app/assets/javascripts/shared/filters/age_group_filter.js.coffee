AgeGroupFilter = ->
  (age_group) ->
    age_group_mapping =
      "Infant 1 Age Group": "Infant Age",
      "Toddler 1 Age Group": "Toddler Age",
      "Preschool 1 Age Group": "Preschool Age",
      "School Age 1 Group": "School Age",
      "School Age 2 Group": "Any age"

    return age_group_mapping[age_group]

AgeGroupFilter.$inject = []

angular.module('CCR').filter('friendlyAgeGroup', AgeGroupFilter)
