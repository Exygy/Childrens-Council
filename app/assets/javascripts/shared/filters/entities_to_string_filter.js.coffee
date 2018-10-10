EntitiesToStringFilter = (EntitiesToStringService) ->
  (entities) ->
    EntitiesToStringService.toString(entities)

EntitiesToStringFilter.$inject = ['EntitiesToStringService']

angular.module('CCR').filter('entitiesToString', EntitiesToStringFilter)
