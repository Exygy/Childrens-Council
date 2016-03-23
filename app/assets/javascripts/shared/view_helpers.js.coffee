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

IsFacility = ($rootScope) ->
  (care_type_id) ->
    if $rootScope.data['care_types'][care_type_id]
      $rootScope.data['care_types'][care_type_id].facility

IsFacility.$inject = ['$rootScope']
angular.module('CCR').filter('isFacility', IsFacility)

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
        'sunday'
        'saturday'
      ].indexOf(day.name.toLowerCase())
angular.module('CCR').filter('sortDays', SortDays)
