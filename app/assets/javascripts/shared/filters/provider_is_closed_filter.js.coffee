ProviderIsClosedFilter = () ->
  (shiftDays, current_day) ->
    closed = true
    if shiftDays
      for shiftDay in shiftDays
        if shiftDay.day == current_day
          closed = false
    return closed

ProviderIsClosedFilter.$inject = []

angular.module('CCR').filter('providerIsClosed', ProviderIsClosedFilter)
