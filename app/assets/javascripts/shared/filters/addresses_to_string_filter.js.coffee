AddressesToStringFilter = (AddressesToStringService) ->
  (entities) ->
    AddressesToStringService.toString(entities)

AddressesToStringFilter.$inject = ['AddressesToStringService']

angular.module('CCR').filter('addressesToString', AddressesToStringFilter)
