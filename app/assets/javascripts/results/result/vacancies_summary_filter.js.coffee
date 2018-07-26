VacanciesSummaryFilter = ->
	ageToAgeGroup = (age) ->
		return "School Age 2 Group"

	numberOfWeeks = (age_group_obj) ->
		age_group_obj.weeks + (age_group_obj.months / 12 * 52) + (age_group_obj.years * 52)

	openVacancyStatus = (enrollment) ->
		if isFutureVacancy(enrollment.vacancyDate)
			return 'Has vacancies beginning ' + enrollment.vacancyDate
		else
			return 'Has current vacancies'

	checkFCCVacancy = (enrollment) ->
		if numberOfWeeks(provider.ageGroupFrom) < age_in_weeks and age_in_weeks > numberOfWeeks(provider.ageGroupTo)
			if isFutureVacancy(enrollment.vacancyDate)
				return 'Has vacancies beginning ' + enrollment.vacancyDate
			else
				return 'Has current vacancies'
		else
			return 'No vacancies'

	enrollmentHasVacancy = (enrollment) ->
		enrollment.vacancyDate and (enrollment.ftVacancies > 0 or enrollment.ptVacancies > 0)

	isFutureVacancy = (date) ->
		Date.parse(date) > Date.now()

	isFCCVacancy = (enrollment) ->
		enrollment.ageGroup.indexOf('FCC') > -1

	checkEnrollments = (enrollments) ->
		status = 'No vacancies'

		for enrollment in enrollments
			if enrollment.ageGroup == ageToAgeGroup(age_in_weeks)
				break unless enrollmentHasVacancy()
				status = openVacancyStatus(enrollment)

				if isFCCVacancy(enrollment) and status == 'No vacancies' and enrollmentHasVacancy(enrollment)
					status = checkFCCVacancy(enrollment)

				if status != 'No vacancies'
					return status

		return status

  (provider, age_in_weeks) ->
		return checkEnrollments(provider.enrollments)

VacanciesSummaryFilter.$inject = []

angular.module('CCR').filter('vacanciesSummary', VacanciesSummaryFilter)
