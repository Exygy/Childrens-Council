VacancyToString = (filters) ->
  string = ''
  if filters.vacancyType and filters.vacancyType.length
    if filters.vacancyType[0] == 'Available Now'
      string = filters.vacancyType[0]
    else
      string = 'Available beginning ' + filters.vacancyFutureDate
  if string != '' then string else 'Any'

angular.module('CCR').filter('vacancyToString', () -> (rates) -> VacancyToString(rates))
