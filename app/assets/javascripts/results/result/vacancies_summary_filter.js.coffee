VacanciesSummaryFilter = (AgeToAgeGroupService) ->

	numberOfWeeks = (age_group_obj) ->
		age_group_obj.weeks + (age_group_obj.months / 12 * 52) + (age_group_obj.years * 52)

	openVacancyStatus = (enrollment) ->
		if isFutureVacancy(enrollment.vacancyDate)
			return 'Has vacancies beginning ' + enrollment.vacancyDate
		else
			return 'Has current vacancies'

	formatDate = (date) ->
		date_parts = date.split("-")
		year = date_parts[0]
		month = date_parts[1]
		day = date_parts[2]
		return month + '/' + day + '/' + year

	checkFCCVacancy = (provider, enrollment) ->
		if numberOfWeeks(provider.ageGroupFrom) < age_in_weeks and age_in_weeks > numberOfWeeks(provider.ageGroupTo)
			if isFutureVacancy(enrollment.vacancyDate)
				return 'Has vacancies beginning ' + formatDate(enrollment.vacancyDate)
			else
				return 'Has current vacancies'
		else
			return 'No vacancies'

	enrollmentHasVacancy = (enrollment) ->
		enrollment.vacancyDate and ((enrollment.ftVacancies and enrollment.ftVacancies > 0) or (enrollment.ptVacancies and enrollment.ptVacancies > 0))

	isFutureVacancy = (date) ->
		Date.parse(date) > Date.now()

	isFCCVacancy = (enrollment) ->
		enrollment.ageGroupTypeId == 109

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
		age_groups = AgeToAgeGroupService.ageToAgeGroup(age_in_weeks)

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

VacanciesSummaryFilter.$inject = ['AgeToAgeGroupService']

angular.module('CCR').filter('vacanciesSummary', VacanciesSummaryFilter)
