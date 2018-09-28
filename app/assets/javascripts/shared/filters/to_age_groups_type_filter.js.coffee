ToAgeGroupTypeFilter = (DataService) ->
  (age_group_type_id) ->
    age_group_types = DataService.filterData['ageGroupTypes']
    return age_group_types[age_group_type_id].value

ToAgeGroupTypeFilter.$inject = ['DataService']

angular.module('CCR').filter('toAgeGroupType', ToAgeGroupTypeFilter)
