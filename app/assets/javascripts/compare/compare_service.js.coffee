CompareService = (DataService, HttpService) ->
  $service = @
  $service.data = {
    child: DataService.parent.children[0],
    currentPageNum: 0
    currentPageProviders: []
    hideMapPager: true
    mapFullWidth: true
    maxPageNum: 0
    pageSize: 3
    providerIds: []
    providers: []
    showMoreDetails: false
  }
  $service.maxProvidersToCompare = 8
  $service.pageSize = 3

  setCurrentProviders = ->
    startIndex = $service.data.currentPageNum * $service.pageSize
    endIndex = startIndex + $service.pageSize
    $service.data.currentPageProviders = $service.data.providers.slice(startIndex, endIndex)

    if $service.data.currentPageProviders.length <= 0 && $service.data.currentPageNum > 0
      $service.data.currentPageNum--
      setCurrentProviders()
    else
      $service.data.maxPageNum = Math.ceil($service.data.providers.length / $service.pageSize) - 1


  $service.fetchProviders = (callback) ->
    that = @

    notYetFetchedIds = $service.data.providerIds.filter(
      (id) -> !$service.data.providers.find((p) -> p.providerId == id)
    )

    if notYetFetchedIds.length > 0
      HttpService.http(
        { method: 'POST', url: '/api/providers/bulk_fetch', data: {provider_ids: notYetFetchedIds} },
        (response) ->
          $service.data.providers.push(response.data.content...)
          setCurrentProviders()
          callback() if callback

        (error) ->
          console.log("ERROR")
          console.log(error)
      )
    else
      setCurrentProviders()
      callback() if callback

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

  $service.showMoreDetails = ->
    $service.data.showMoreDetails = true

  $service

CompareService.$inject = ['DataService', 'HttpService']
angular.module('CCR').service('CompareService', CompareService)
