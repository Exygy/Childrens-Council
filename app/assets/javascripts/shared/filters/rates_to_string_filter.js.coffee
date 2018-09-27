RatesToString = (rates) ->
  string = ''
  if rates[1]
    string = '$' + rates[0] + '—$' + rates[1] + ' per month'
  if string != '' then string else 'Any'

angular.module('CCR').filter('ratesToString', () -> (rates) -> RatesToString(rates))
