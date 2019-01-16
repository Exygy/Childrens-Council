AddressesToStringService = ->
  @toString = (addresses) ->
    if addresses.length == 1
      addresses[0]
    else
      'Between ' + _.join(addresses, ' and ')

  return @

AddressesToStringService.$inject = []
angular.module('CCR').service('AddressesToStringService', AddressesToStringService)
