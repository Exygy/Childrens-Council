CompareService = (DataService) ->
  $service = @

  $service.providerIdsToCompare = []
  $service.maxProvidersToCompare = 8

  $service

CompareService.$inject = ['DataService']
angular.module('CCR').service('CompareService', CompareService)
