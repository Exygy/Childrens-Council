VacancyDateService = ->
  $service = @

  $service.dates = () ->
    today = new Date
    dd = today.getDate()
    mm = today.getMonth() + 1
    yyyy = today.getFullYear()
    if dd < 10
      dd = '0' + dd
    if mm < 10
      mm = '0' + mm

    values =
      today: yyyy+ '-' + mm + '-' + dd
      future: (yyyy+10) + '-' + mm + '-' + dd
      past: (yyyy-6) + '-' + mm + '-' + dd

    return values

  $service.format_future_date = (vacancyFutureDate) ->
    date_elements = vacancyFutureDate.split('/')
    return date_elements[2] + '-' + date_elements[0] + '-' + date_elements[1]

  $service.convert = (vacancyType, vacancyFutureDate) ->
    dates = $service.dates()

    if vacancyType
      switch vacancyType[0]
        when 'Available Now'
          params =
            from: dates.past,
            to: dates.today
        when 'Future Date'
          params =
            from: $service.format_future_date(vacancyFutureDate),
            to: dates.future
    return params

  return $service

VacancyDateService.$inject = []

angular.module('CCR').service('VacancyDateService', VacancyDateService)
