FinancialAssistanceToFilterTitleFilter = ->
  (names) ->
    if names && names.length && names[0] != ''
      EntitiesToString(names)
    else
      'Any (all options)'

angular.module('CCR').filter('financialAssistanceToFilterTitle', FinancialAssistanceToFilterTitleFilter)
