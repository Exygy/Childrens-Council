FilterProvidersBasedOnEmailCollectorStatus = ->
  (providers, applyFilter) ->
    
    console.log('FilterProvidersBasedOnEmailCollectorStatus')
    console.log(providers)
    console.log(applyFilter)
    
    if applyFilter
        return providers #.slice(0, 5)
    else
        return providers

FilterProvidersBasedOnEmailCollectorStatus.$inject = []

angular.module('CCR').filter('filterProvidersBasedOnEmailCollectorStatus', FilterProvidersBasedOnEmailCollectorStatus)