PhysicalAddressFilter = ->
  (addresses, field) ->
    for address in addresses
      if address.type == 'Physical Address'
        return address[field]
    return ''

PhysicalAddressFilter.$inject = []

angular.module('CCR').filter('physicalAddress', PhysicalAddressFilter)
