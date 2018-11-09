FinancialAssistanceToFilterTitleFilter = (EntitiesToStringService) ->
  (names) ->
    if names && names.length && names[0] != ''
      EntitiesToStringService.toString(names)
    else
      'Any (all options)'

FinancialAssistanceToFilterTitleFilter.$inject = ['EntitiesToStringService']

angular.module('CCR').filter('financialAssistanceToFilterTitle', FinancialAssistanceToFilterTitleFilter)
