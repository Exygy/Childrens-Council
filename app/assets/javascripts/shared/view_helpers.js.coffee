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

AgeToYearsAndMonths = () ->
  (age_in_months) ->
    years = Math.floor age_in_months / 12
    months = age_in_months % 12
    age_text = "#{years} yrs"
    age_text += " #{months} mon" if months
    age_text
angular.module('CCR').filter('ageToYearsAndMonths', AgeToYearsAndMonths)
