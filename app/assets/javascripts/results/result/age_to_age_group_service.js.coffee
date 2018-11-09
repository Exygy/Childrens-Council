AgeToAgeGroupService = () ->

  @ageToAgeGroup = (age_in_weeks) ->
  	age_in_months = age_in_weeks / 4.3

  	age_group_to_age_in_month_mapping = {
  		'Infant 1 Age Group': [0, 23],
  		'Toddler 1 Age Group': [18, 36],
  		'Preschool 1 Age Group': [24, 71],
  		'School Age 1 Group': [72, 1188]
  	}

  	age_groups = ['School Age 2 Group']
  	for age_group, age_range of age_group_to_age_in_month_mapping
  			if age_range[0] <= age_in_months && age_in_months <= age_range[1]
  				age_groups.push(age_group)

  	return age_groups

  @

AgeToAgeGroupService.$inject = []

angular.module('CCR').service('AgeToAgeGroupService', AgeToAgeGroupService)
