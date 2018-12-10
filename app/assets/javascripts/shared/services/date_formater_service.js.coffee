DateFormaterService = ->
  @formatTime = (dateStr) ->
    date = moment(dateStr, 'HH:mm:ss').format(DEFAULT_DATE_FORMAT)

    date = date.replace('pm','p.m').replace('am','a.m')

    return date

  return @

DateFormaterService.$inject = []
angular.module('CCR').service('DateFormaterService', DateFormaterService)
