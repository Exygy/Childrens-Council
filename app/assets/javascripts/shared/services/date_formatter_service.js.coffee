DateFormatterService = ->
  @formatTime = (dateStr) ->
    date = moment(dateStr, 'HH:mm:ss').format(DEFAULT_DATE_FORMAT)
    return date.replace('pm','p.m').replace('am','a.m')

  return @

DateFormatterService.$inject = []
angular.module('CCR').service('DateFormatterService', DateFormatterService)
