EntitiesToStringService = ->
  @toString = (entities) ->
    string = ''
    for entity, index in entities
      string += entity
      if index+1 != entities.length
        string += if index+2 == entities.length then ' and ' else ', '
    if string != '' then string else 'None'

  return @

EntitiesToStringService.$inject = []
angular.module('CCR').service('EntitiesToStringService', EntitiesToStringService)
