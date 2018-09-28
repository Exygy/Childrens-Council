AgeToYearsAndMonthsFilter = () ->
  (ageInWeeks) ->
    years = Math.floor ageInWeeks / 52
    months = Math.floor (ageInWeeks * (3.0 / 13)) % 12
    age_text = ''
    age_text += "#{years} yrs " if years
    age_text += "#{months} mon" if months or (!years and !months)
    age_text

angular.module('CCR').filter('ageToYearsAndMonths', AgeToYearsAndMonthsFilter)
