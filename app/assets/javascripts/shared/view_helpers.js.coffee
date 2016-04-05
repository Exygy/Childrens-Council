CareReasonIdToName = ($rootScope) ->
  (care_reason_id) ->
    if $rootScope.data['care_reasons'][care_reason_id]
        $rootScope.data['care_reasons'][care_reason_id].name

CareReasonIdToName.$inject = ['$rootScope']
angular.module('CCR').filter('careReasonIdToName', CareReasonIdToName)

CareTypeIdToName = ($rootScope) ->
  (care_type_id) ->
    if $rootScope.data['care_types'][care_type_id]
      $rootScope.data['care_types'][care_type_id].name

CareTypeIdToName.$inject = ['$rootScope']
angular.module('CCR').filter('careTypeIdToName', CareTypeIdToName)

ProgramIdToName = ($rootScope) ->
  (program_id) ->
    if $rootScope.data['programs'][program_id]
      $rootScope.data['programs'][program_id].name

ProgramIdToName.$inject = ['$rootScope']
angular.module('CCR').filter('programIdToName', ProgramIdToName)

CareTypeIdsToNames = ($rootScope) ->
  (care_type_ids) ->
    care_type_names = []
    if care_type_ids
      for care_type_id in care_type_ids
        if $rootScope.data['care_types'][care_type_id]
          care_type_names.push $rootScope.data['care_types'][care_type_id].name
    EntitiesToString(care_type_names)

CareTypeIdsToNames.$inject = ['$rootScope']
angular.module('CCR').filter('careTypeIdsToNames', CareTypeIdsToNames)

IsFacility = ($rootScope) ->
  (care_type_id) ->
    ProviderIsFacility($rootScope, care_type_id)

IsFacility.$inject = ['$rootScope']
angular.module('CCR').filter('isFacility', IsFacility)

ProviderIsFacility = ($rootScope, care_type_id) ->
  if $rootScope.data['care_types'][care_type_id]
    $rootScope.data['care_types'][care_type_id].facility
  else
    false

LanguageIdToName = ($rootScope) ->
  (language_id) ->
    if $rootScope.data['languages'][language_id]
      $rootScope.data['languages'][language_id].name

LanguageIdToName.$inject = ['$rootScope']
angular.module('CCR').filter('languageIdToName', LanguageIdToName)

NeighborhoodIdToName = ($rootScope) ->
  (neighborhood_id) ->
    if $rootScope.data['neighborhoods'][neighborhood_id]
      $rootScope.data['neighborhoods'][neighborhood_id].name

NeighborhoodIdToName.$inject = ['$rootScope']
angular.module('CCR').filter('neighborhoodIdToName', NeighborhoodIdToName)

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

ZipCodeIdToName = ($rootScope) ->
  (zip_code_id) ->
    if $rootScope.data['zip_codes'][zip_code_id]
      $rootScope.data['zip_codes'][zip_code_id].zip

ZipCodeIdToName.$inject = ['$rootScope']
angular.module('CCR').filter('zipCodeIdToName', ZipCodeIdToName)

ScheduleDayIdToName = ($rootScope) ->
  (schedule_day_id) ->
    if $rootScope.data['schedule_days'][schedule_day_id]
      $rootScope.data['schedule_days'][schedule_day_id].name

ScheduleDayIdToName.$inject = ['$rootScope']
angular.module('CCR').filter('scheduleDayIdToName', ScheduleDayIdToName)

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
  (age_in_months) ->
    years = Math.floor age_in_months / 12
    months = age_in_months % 12
    age_text = ''
    age_text += "#{years} yrs " if years
    age_text += "#{months} mon" if months
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

SortDays = () ->
  (days) ->
    _.sortBy days, (day) ->
      [
        'monday'
        'tuesday'
        'wednesday'
        'thursday'
        'friday'
        'saturday'
        'sunday'
      ].indexOf(day.name.toLowerCase())
angular.module('CCR').filter('sortDays', SortDays)

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
    retained_programs

ProgramsByProgramType.$inject = ['$rootScope']
angular.module('CCR').filter('programsByProgramType', ProgramsByProgramType)

OrderByWeekDays = () ->
  (schedule_hours) ->
    schedule_hours
    _.sortBy(schedule_hours, 'schedule_day_id')

angular.module('CCR').filter('orderByWeekDays', OrderByWeekDays)

SubsidiesToFilterTitle = ($rootScope) ->
  (subsidy_ids) ->
    if subsidy_ids.length and subsidy_ids[0] != ''
      names = []
      for subsidy_id in subsidy_ids
        names.push $rootScope.data['subsidies'][subsidy_id].name
      EntitiesToString(names)
    else
      'Any (all options)'

SubsidiesToFilterTitle.$inject = ['$rootScope']
angular.module('CCR').filter('subsidiesToFilterTitle', SubsidiesToFilterTitle)

ProviderName = ($rootScope) ->
  (provider) ->
    FormatProviderName(provider, $rootScope, provider.name)

ProviderName.$inject = ['$rootScope']
angular.module('CCR').filter('providerName', ProviderName)

ProviderContactName = ($rootScope) ->
  (provider) ->
    FormatProviderName(provider, $rootScope, provider.contact_name)

ProviderContactName.$inject = ['$rootScope']
angular.module('CCR').filter('providerContactName', ProviderContactName)

FormatProviderName = (provider, rootScope, name) ->
  if !ProviderIsFacility(rootScope, provider.care_type_id)
    # /.+,\s*\w{1}/
    names = name.split(',')
    if names.length == 2
      first_name = names[1].trim()
      last_name = names[0]
      return last_name + ' ' + first_name[0] + '.'
    if names.length == 1
      names = name.split(' ')
      first_name = names[1].trim()
      last_name = names[0]
      return last_name + ' ' + first_name[0] + '.'
  else
    return name

EntitiesToString = (entities) ->
  string = ''
  for entity, index in entities
    string += entity
    if index+1 != entities.length
      string += if index+2 == entities.length then ' and ' else ', '
  string

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

ScheduleDayIdsToText = ($rootScope) ->
  (schedule_day_ids) ->
    days = []
    for schedule_day_id in schedule_day_ids
      days.push $rootScope.data['schedule_days'][schedule_day_id].name
    days = days.sort (a, b) ->
      week_days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
      week_days.indexOf(a) - week_days.indexOf(b)
    if days.length == 5 and days[0] == 'Monday' and days[days.length-1] == 'Friday'
      return days[0] + ' - ' + days[days.length-1]
    if days.length == 2 and days[0] == 'Saturday' and days[days.length-1] == 'Sunday'
      return days[0] + ' - ' + days[days.length-1]
    if days.length == 7
      return 'All week'
    if days.length == 7
      return 'None'
    return EntitiesToString(days)

ScheduleDayIdsToText.$inject = ['$rootScope']
angular.module('CCR').filter('scheduleDayIdsToText', ScheduleDayIdsToText)
