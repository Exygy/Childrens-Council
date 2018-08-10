VacanciesSummaryFilter = ->

	ageToAgeGroup = (age_in_weeks) ->
		age_in_months = age_in_weeks / 4.3

		age_group_to_age_in_month_mapping = {
			'Infant 1 Age Group': [0, 23],
			'Toddler 1 Age Group': [18, 36],
			'Preschool 1 Age Grp': [24, 71],
			'School Age 1 Group': [72, 1188]
		}

		age_groups = ['School Age 2 Group']
		for age_group, age_range of age_group_to_age_in_month_mapping
				if age_range[0] <= age_in_months && age_in_months <= age_range[1]
					age_groups.push(age_group)

		return age_groups

	numberOfWeeks = (age_group_obj) ->
		age_group_obj.weeks + (age_group_obj.months / 12 * 52) + (age_group_obj.years * 52)

	openVacancyStatus = (enrollment) ->
		if isFutureVacancy(enrollment.vacancyDate)
			return 'Has vacancies beginning ' + enrollment.vacancyDate
		else
			return 'Has current vacancies'

	checkFCCVacancy = (provider, enrollment) ->
		if numberOfWeeks(provider.ageGroupFrom) < age_in_weeks and age_in_weeks > numberOfWeeks(provider.ageGroupTo)
			if isFutureVacancy(enrollment.vacancyDate)
				return 'Has vacancies beginning ' + enrollment.vacancyDate
			else
				return 'Has current vacancies'
		else
			return 'No vacancies'

	enrollmentHasVacancy = (enrollment) ->
		enrollment.vacancyDate and ((enrollment.ftVacancies and enrollment.ftVacancies > 0) or (enrollment.ptVacancies and enrollment.ptVacancies > 0))

	isFutureVacancy = (date) ->
		Date.parse(date) > Date.now()

	isFCCVacancy = (enrollment) ->
		enrollment.ageGroup.indexOf('FCC') > -1

	orderStatuses = (statuses) ->
		return statuses.sort (a, b) ->
			if b.indexOf('Has current vacancies') > -1
					return 2
			if b.indexOf('No vacancies') > -1
			    return -1
			else
					return 1

	checkEnrollments = (provider, age_in_weeks) ->
		statuses = ['No vacancies']
		age_groups = ageToAgeGroup(age_in_weeks)

		for enrollment in provider.enrollments
			if age_groups.indexOf(enrollment.ageGroup) > -1
				break unless enrollmentHasVacancy(enrollment)
				status = openVacancyStatus(enrollment)

				if isFCCVacancy(enrollment) and status == 'No vacancies' and enrollmentHasVacancy(enrollment)
					status = checkFCCVacancy(provider, enrollment)

				if status != 'No vacancies'
					statuses.push status

		statuses = orderStatuses(statuses)

		return statuses[0]

VacanciesSummaryFilter.$inject = []

angular.module('CCR').filter('vacanciesSummary', VacanciesSummaryFilter)
