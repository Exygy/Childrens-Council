BooleanFilterToTextFilter = ->
  (bool_filter) ->
    if bool_filter?
      if bool_filter
        'Yes'
      else
        'No'
    else
      'Any'

angular.module('CCR').filter('booleanFilterToText', BooleanFilterToTextFilter)
