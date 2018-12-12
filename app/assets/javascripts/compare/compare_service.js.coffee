CompareService = (DataService) ->
  $service = @
  $service.data = {
    currentPageNum: 0,
    currentPageProviders: [],
    maxPageNum: 0,
    providerIds: [],
    providers: []
  }
  $service.maxProvidersToCompare = 8
  $service.pageSize = 3

  setCurrentProviders = ->
    startIndex = $service.data.currentPageNum * $service.pageSize
    endIndex = startIndex + $service.pageSize
    $service.data.currentPageProviders = $service.data.providers.slice(startIndex, endIndex)
    $service.data.maxPageNum = Math.ceil($service.data.providers.length / $service.pageSize) - 1

  $service.fetchProviders = ->
    $service.data.providers = $service.data.providerIds.map((id) ->
      DataService.searchResultsData.providers.find((p) ->
        p.providerId == id
      )
    )
    setCurrentProviders()

  $service.prevPage = ->
    if $service.data.currentPageNum > 0
      $service.data.currentPageNum--
      setCurrentProviders()

  $service.nextPage = ->
    if $service.data.currentPageNum < $service.data.maxPageNum
      $service.data.currentPageNum++
      setCurrentProviders()

  $service.removeProviderFromCompare = (id) ->
    $service.data.providerIds.splice($service.data.providerIds.indexOf(id), 1)
    $service.data.providers = $service.data.providers.filter((p) ->
      p.providerId != id
    )
    setCurrentProviders()

  $service

CompareService.$inject = ['DataService']
angular.module('CCR').service('CompareService', CompareService)
