AddressesToStringService = ->
  @toString = (addresses) ->
    if _.isEmpty(addresses)
      'None'
    else if addresses.length == 1
      addresses[0]
    else
      'Between ' + _.join(addresses, ' and ')

  return @

AddressesToStringService.$inject = []
angular.module('CCR').service('AddressesToStringService', AddressesToStringService)
