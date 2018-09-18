CareReasonIdToName = ($rootScope) ->
  (care_reason_id) ->
    if $rootScope.data['care_reasons'][care_reason_id]
        $rootScope.data['care_reasons'][care_reason_id].name

CareReasonIdToName.$inject = ['$rootScope']
angular.module('CCR').filter('careReasonIdToName', CareReasonIdToName)

CareTypeIdsToNames = (DataService) ->
  (ids) ->
    careTypeNames = []
    if ids
      ids.forEach((id) ->
        typeName = DataService.filterData.typesOfCare.find((type) -> type.id == id)
        careTypeNames.push(typeName.name)
      )
    EntitiesToString(careTypeNames)

CareTypeIdsToNames.$inject = ['DataService']
angular.module('CCR').filter('careTypeIdsToNames', CareTypeIdsToNames)

IsFacility = ($rootScope) ->
  (provider) ->
    ProviderIsFacility($rootScope, provider)

IsFacility.$inject = ['$rootScope']
angular.module('CCR').filter('isFacility', IsFacility)

ProviderIsFacility = ($rootScope, provider) ->
  if provider
    return provider.typeOfCare == "Child Care Center"
  else
    return false

StateIdToName = ($rootScope) ->
  (state_id) ->
    if $rootScope.data['states'][state_id]
      $rootScope.data['states'][state_id].name

StateIdToName.$inject = ['$rootScope']
angular.module('CCR').filter('stateIdToName', StateIdToName)

StateIdToAbbr = ($rootScope) ->
  (state_id) ->
    if $rootScope.data['states'][state_id]
      $rootScope.data['states'][state_id].abbr
StateIdToAbbr.$inject = ['$rootScope']
angular.module('CCR').filter('stateIdToAbbr', StateIdToAbbr)

CityIdToName = ($rootScope) ->
  (city_id) ->
    if $rootScope.data['cities'][city_id]
      $rootScope.data['cities'][city_id].text

CityIdToName.$inject = ['$rootScope']
angular.module('CCR').filter('cityIdToName', CityIdToName)

FormatPhoneNumber = () ->
  (tel) ->
    if !tel
      return ''
    value = tel.toString().trim().replace(/^\+/, '')
    if value.match(/[^0-9]/)
      return tel
    country = undefined
    city = undefined
    number = undefined
    switch value.length
      when 10
        # +1PPP####### -> C (PPP) ###-####
        country = 1
        city = value.slice(0, 3)
        number = value.slice(3)
      when 11
        # +CPPP####### -> CCC (PP) ###-####
        country = value[0]
        city = value.slice(1, 4)
        number = value.slice(4)
      when 12
        # +CCCPP####### -> CCC (PP) ###-####
        country = value.slice(0, 3)
        city = value.slice(3, 5)
        number = value.slice(5)
      else
        return tel
    if country == 1
      country = ''
    number = number.slice(0, 3) + '-' + number.slice(3)
    (country + ' (' + city + ') ' + number).trim()
angular.module('CCR').filter('formatPhoneNumber', FormatPhoneNumber)

PrefixUrl = () ->
  (value) ->
    return value if !value
    return value if 'http://'.indexOf(value) == 0 or 'https://'.indexOf(value) == 0
    return value if value.indexOf('http://') == 0 or value.indexOf('https://') == 0
    return 'http://' + value
angular.module('CCR').filter('prefixUrl', PrefixUrl)

AgeToYearsAndMonths = () ->
  (ageInWeeks) ->
    years = Math.floor ageInWeeks / 52
    months = Math.floor (ageInWeeks * (3.0 / 13)) % 12
    age_text = ''
    age_text += "#{years} yrs " if years
    age_text += "#{months} mon" if months or (!years and !months)
    age_text
angular.module('CCR').filter('ageToYearsAndMonths', AgeToYearsAndMonths)

AbbreviateDay = () ->
  (day_of_week) ->
    if day_of_week.length > 3 then day_of_week.substr(0, 3) else day_of_week
angular.module('CCR').filter('abbreviateDay', AbbreviateDay)

Attribute = () ->
  (attribute) ->
    _.kebabCase(attribute)
angular.module('CCR').filter('attribute', Attribute)

ProgramsWithProgramTypeByName = ($rootScope) ->
  (programs, program_type_name) ->
    retained_programs = []
    if $rootScope.data['program_types']
      for index, program_type of $rootScope.data['program_types']
        if program_type.name == program_type_name
          for program of programs
            if program.program_type_id == program_type.id
              retained_programs.push program.name
    if retained_programs.length then EntitiesToString(care_type_namesretained_programs) else null

ProgramsWithProgramTypeByName.$inject = ['$rootScope']
angular.module('CCR').filter('programsWithProgramTypeByName', ProgramsWithProgramTypeByName)

HasProgramByName = () ->
  (programs, program_name) ->
    has_program = 'No'
    for program in programs
      if program.name == program_name
        has_program = 'Yes'
    has_program
angular.module('CCR').filter('hasProgramByName', HasProgramByName)

Capitalize = () ->
  (input) ->
    if input then input.charAt(0).toUpperCase() + input.substr(1).toLowerCase() else ''
angular.module('CCR').filter('capitalize', Capitalize)

ToAgeFromInMonths = () ->
  (license) ->
    license.age_from_year * 12 + license.age_from_month
angular.module('CCR').filter('toAgeFromInMonths', ToAgeFromInMonths)

ToAgeToInMonths = () ->
  (license) ->
    license.age_to_year * 12 + license.age_to_month
angular.module('CCR').filter('toAgeToInMonths', ToAgeToInMonths)

ProgramsByProgramType = ($rootScope) ->
  (programs, program_type_name) ->
    retained_programs = []
    if $rootScope.data['program_types_array']
      for program_type in $rootScope.data['program_types_array']
        if program_type.name == program_type_name
          for program in programs
            if program.program_type_id == program_type.id
              retained_programs.push program
    retained_programs.sort (a,b) -> return (a.name > b.name) ? 1 : ((b.name > a.name) ? -1 : 0)

ProgramsByProgramType.$inject = ['$rootScope']
angular.module('CCR').filter('programsByProgramType', ProgramsByProgramType)

ShiftDay = () ->
  (shiftDays, current_day) ->
    for shiftDay in shiftDays
      if shiftDay.day == current_day
        return shiftDay

ShiftDay.$inject = []
angular.module('CCR').filter('shiftDay', ShiftDay)

ShortDayName = () ->
  (day) ->
    return day.substring(0, 3);

ShortDayName.$inject = []
angular.module('CCR').filter('shortDayName', ShortDayName)

FormatProviderStartEndDate = ->
  (date) ->
    date_parts = date.split(':')
    time = date_parts[0] + ':' + date_parts[1]
    if (date_parts[0] - 12) > 0
      ampm = "PM"
      hour = date_parts[0] - 12
      if hour == 0
        hour = "12"
    else
      ampm = "AM"
      hour = date_parts[0]
    return hour + ':' + date_parts[1] + " " + ampm

FormatProviderStartEndDate.$inject = []
angular.module('CCR').filter('formatProviderStartEndDate', FormatProviderStartEndDate)

ProviderIsClosed = () ->
  (shiftDays, current_day) ->
    closed = true
    if shiftDays
      for shiftDay in shiftDays
        if shiftDay.day == current_day
          closed = false
    return closed

ProviderIsClosed.$inject = []
angular.module('CCR').filter('providerIsClosed', ProviderIsClosed)

FinancialAssistanceToFilterTitle = ->
  (names) ->
    if names && names.length && names[0] != ''
      EntitiesToString(names)
    else
      'Any (all options)'

angular.module('CCR').filter('financialAssistanceToFilterTitle', FinancialAssistanceToFilterTitle)

ProviderName = ($rootScope) ->
  (provider) ->
    if provider?
      FormatProviderName(provider, $rootScope, provider.centerName)
    else
      ''

ProviderName.$inject = ['$rootScope']
angular.module('CCR').filter('providerName', ProviderName)

ProviderContactName = ($rootScope) ->
  (provider) ->
    if provider?
      FormatProviderName(provider, $rootScope, provider.contact_name)
    else
      ''

ProviderContactName.$inject = ['$rootScope']
angular.module('CCR').filter('providerContactName', ProviderContactName)

FormatProviderName = (provider, rootScope, name) ->
  if name
    return "#{name}"
  else
    return "#{provider.primaryOwner.firstName} #{provider.primaryOwner.lastName}"


EntitiesToString = (entities) ->
  string = ''
  for entity, index in entities
    string += entity
    if index+1 != entities.length
      string += if index+2 == entities.length then ' and ' else ', '
  if string != '' then string else 'None'

angular.module('CCR').filter('entitiesToString', () -> (entities) -> EntitiesToString(entities))

BooleanFilterToText = ->
  (bool_filter) ->
    if bool_filter?
      if bool_filter
        'Yes'
      else
        'No'
    else
      'Any'
angular.module('CCR').filter('booleanFilterToText', BooleanFilterToText)

ScheduleDaysToText = (DataService) ->
  (days) ->
    if days?
      allDays = DataService.filterData.days
      days = days.sort (a, b) -> allDays.indexOf(a) - allDays.indexOf(b)
      if days.length == 5 and days[0] == 'Monday' and days[days.length-1] == 'Friday'
        return 'Monday - Friday'
      else if days.length == 2 and days[0] == 'Saturday' and days[days.length-1] == 'Sunday'
        return 'Saturday - Sunday'
      else if days.length == 7
        return 'All week'
      else if days.length == 0
        return 'None'
      else
        return EntitiesToString(days)

ScheduleDaysToText.$inject = ['DataService']
angular.module('CCR').filter('scheduleDaysToText', ScheduleDaysToText)

ScheduleYearValueToLabel = (DataService) ->
  (value) ->
    sched = DataService.filterData.yearlySchedules.find((sched) -> sched.value == value)
    sched.label if sched

ScheduleYearValueToLabel.$inject = ['DataService']
angular.module('CCR').filter('scheduleYearValueToLabel', ScheduleYearValueToLabel)

MealsToFilterTitle = () ->
  (meals) ->
    if meals && meals.length
      if meals[0] == 'dummy value for no meals'
        'No'
      else
        'Yes'
    else
      'Any'

angular.module('CCR').filter('mealsToFilterTitle', MealsToFilterTitle)

PottyTraining = ($rootScope) ->
  (provider_attributes) ->
    potty_training = false
    if provider_attributes and provider_attributes.environment
      for environment in provider_attributes.environment
        if environment == "Potty Training"
          potty_training = true
    return potty_training

PottyTraining.$inject = ['$rootScope']
angular.module('CCR').filter('pottyTraining', PottyTraining)

ToAgeGroupType = (DataService) ->
  (age_group_type_id) ->
    age_group_types = DataService.filterData['ageGroupTypes']
    return age_group_types[age_group_type_id].value

ToAgeGroupType.$inject = ['DataService']
angular.module('CCR').filter('toAgeGroupType', ToAgeGroupType)
