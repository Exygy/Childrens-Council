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

  $service.fetchProviders = ->
    $service.data.providers = $service.data.providerIds.map((id) ->
      DataService.searchResultsData.providers.find((p) ->
        p.providerId == id
      )
    )
    $service.data.maxPageNum = Math.floor($service.data.providers.length / $service.pageSize)
    setCurrentProviders()

  $service.prevPage = ->
    if $service.data.currentPageNum > 0
      $service.data.currentPageNum--
      setCurrentProviders()

  $service.nextPage = ->
    if $service.data.currentPageNum < $service.data.maxPageNum
      $service.data.currentPageNum++
      setCurrentProviders()

  $service

CompareService.$inject = ['DataService']
angular.module('CCR').service('CompareService', CompareService)
