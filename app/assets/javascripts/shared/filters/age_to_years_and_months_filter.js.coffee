AgeToYearsAndMonthsFilter = () ->
  (ageInWeeks) ->
    years = Math.floor ageInWeeks / 52
    months = Math.floor (ageInWeeks * (3.0 / 13)) % 12
    age_text = ''
    if years
      age_text += "#{years} yr"
      age_text += (if years == 1 then ' ' else 's ')
    age_text += "#{months} mon" if months or (!years and !months)
    age_text

angular.module('CCR').filter('ageToYearsAndMonths', AgeToYearsAndMonthsFilter)

FormatYearsMonthsWeeksAgeFilter = () ->
  (provider, ageObj) ->
    ageInWeeks = (ageObj.years * 52) + (ageObj.months * 4) + ageObj.weeks
    AgeToYearsAndMonthsFilter()(ageInWeeks)

angular.module('CCR').filter('formatYearsMonthsWeeksAge', FormatYearsMonthsWeeksAgeFilter)
