VacanciesSummaryFilter = (AgeToAgeGroupService) ->
	noVacanciesMsg = 'Contact program for details'

	numberOfWeeks = (ageGroupObj) ->
		ageGroupObj.weeks + (ageGroupObj.months / 12 * 52) + (ageGroupObj.years * 52)

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
		if numberOfWeeks(provider.ageGroupFrom) < ageInWeeks and ageInWeeks > numberOfWeeks(provider.ageGroupTo)
			if isFutureVacancy(enrollment.vacancyDate)
				return 'Has vacancies beginning ' + formatDate(enrollment.vacancyDate)
			else
				return 'Has current vacancies'
		else
			return noVacanciesMsg

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
			if b.indexOf(noVacanciesMsg) > -1
			    return -1
			else
					return 1

	checkEnrollments = (provider, ageInWeeks) ->
		statuses = [noVacanciesMsg]
		ageGroups = AgeToAgeGroupService.ageToAgeGroup(ageInWeeks)

		for enrollment in provider.enrollments
			if ageGroups.indexOf(enrollment.ageGroup) > -1
				break unless enrollmentHasVacancy(enrollment)
				status = openVacancyStatus(enrollment)

				if isFCCVacancy(enrollment) and status == noVacanciesMsg and enrollmentHasVacancy(enrollment)
					status = checkFCCVacancy(provider, enrollment)

				if status != noVacanciesMsg
					statuses.push status

		statuses = orderStatuses(statuses)

		return statuses[0]

VacanciesSummaryFilter.$inject = ['AgeToAgeGroupService']

angular.module('CCR').filter('vacanciesSummary', VacanciesSummaryFilter)
