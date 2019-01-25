SearchService = (
  $http, $cookies, CC_COOKIE, AgeInWeekToAgeGroupsService, VacancyDateService,
  DataService, GeocodingService, HttpService, $rootScope) ->
  $service = @
  $service.filterData = DataService.filterData
  $service.filters = DataService.filters
  $service.parent = DataService.parent
  $service.searchSettings = DataService.searchSettings
  $service.searchResultsData = DataService.searchResultsData

  $rootScope.$on 'data-service:updated', (event, service) ->
    $service.filters = service.filters
    $service.parent = service.parent
    $service.searchSettings = service.searchSettings
    $rootScope.$broadcast('search-service:updated', $service)

  $service.deleteApiKey = ->
    $cookies.remove CC_COOKIE

  $service.postSearch = (callback, opts = {}) ->
    if opts.deleteApiKey
      # reset API KEY == enforce parent authentication
      $service.deleteApiKey()

    if opts.reset
      # in case search fails - will display no results
      DataService.resetData()

    # search
    DataService.current_page = 1
    $service.performSearch callback

  # Rename location params to NDS API names, and ensure addresses have SF in them.
  $service.setSearchLocation = (params) ->
    if params.addresses && _.isEmpty(params.addresses[0])
      delete params.addresses

    if $service.searchSettings.locationType == 'addresses' && params.addresses
      params.addresses = _.map(params.addresses, (address) ->
        if address.indexOf(', San Francisco, CA') == -1
          address += ', San Francisco, CA'
        address
      )
      if params.addresses.length == 1
        params.distance = 5 # set the search radius in miles
      else
        delete params.distance
      delete params.zips
      delete params.neighborhoods
    else if $service.searchSettings.locationType == 'zips' && params.zips.length && params.zips[0].length

      delete params.addresses
      delete params.neighborhoods
    else if $service.searchSettings.locationType == 'neighborhoods' && params.neighborhoods.length && params.neighborhoods[0].length
      params.attributesLocal17 = params.neighborhoods
      delete params.addresses
      delete params.zips

  # Reformat and rename program params to match API fields.
  $service.setPrograms = (params) ->
    # The API field used to search for care approaches and religious programs
    # is the same, so we concatenate these program names into a single list.
    params.generalLocal2 = []

    if params.careApproaches.length && params.careApproaches[0]
      params.generalLocal2 = params.generalLocal2.concat(params.careApproaches)

    if params.religiousPrograms.length && params.religiousPrograms[0]
      params.generalLocal2 = params.generalLocal2.concat(params.religiousPrograms)

    # The Parent Co-Op filter field actually corresponds to the care approach
    # value "Co-op"
    if params.parentCoop
      params.generalLocal2 = _.union(params.generalLocal2, ['Co-op'])

    # The API field called generalLocal1 is used to search for financial
    # assistance programs
    if params.financialAssistance.length
      params.generalLocal1 = params.financialAssistance

    delete params.careApproaches
    delete params.religiousPrograms
    delete params.parentCoop
    delete params.financialAssistance
    delete params.generalLocal2 if !params.generalLocal2.length

  $service.setEnvironments = (params) ->
    if params.pottyTraining
      params.environment = [params.pottyTraining]

    delete params.pottyTraining

  $service.setAgeGroup = (params) ->
    if params.agesServiced
      weeks = params.agesServiced
      params.ageGroups = AgeInWeekToAgeGroupsService.convert(weeks)

  $service.setMonthlyRate = (params) ->
    if params.monthlyRate
      if params.monthlyRate[0] == 0 && params.monthlyRate[1] == 3000
        delete params.monthlyRate
      else
        if params.monthlyRate[1] != 3000
          params.monthlyRate['to'] = params.monthlyRate[1]
          params.monthlyRate =
            from: params.monthlyRate[0]
            to: params.monthlyRate[1]
        else
          params.monthlyRate = from: params.monthlyRate[0]


  $service.setVacancies = (params) ->
    params.vacancyDateRange = VacancyDateService.convert(params.vacancyType, params.vacancyFutureDate)
    delete params.vacancyType
    delete params.vacancyFutureDate

  $service.setAcceptsChildren = (params) ->
    if params.acceptsChildren and params.acceptsChildren.length == 2
      params.acceptsChildren = 'BOTH'
    else
      params.acceptsChildren = params.acceptsChildren[0]

  $service.getSearchParams = ->
    search_params = angular.copy $service.filters

    # those params should be children specific when the feature is built
    search_params.agesServiced = $service.parent.children[0].ageWeeks
    search_params.yearlySchedule = $service.parent.children[0].yearlySchedule
    search_params.weeklySchedule = $service.parent.children[0].weeklySchedule.map((day) -> day.toUpperCase())

    # TODO: set shift info in params
    # @setShiftParams(search_params)
    $service.setSearchLocation(search_params)
    $service.setPrograms(search_params)
    $service.setEnvironments(search_params)
    $service.setAgeGroup(search_params)
    $service.setAcceptsChildren(search_params)
    $service.setMonthlyRate(search_params)
    $service.setVacancies(search_params)

    search_params

  $service.cleanEmptyParams = (params) ->
    deepFilter params, (value, key) ->
      # Filter out empty values and arrays
      if !value? or (Array.isArray(value) and (value.length == 0 or value[0] == '')) then false else true

  $service.getCleanedParent = ->
    parent = angular.copy $service.parent
    delete parent.care_type_ids
    delete parent.agree
    for child, index in parent.children
      delete parent.children[index].weeklySchedule
      delete parent.children[index].shiftFeatures
      delete parent.children[index].selected
    parent

  $service.queryParams = ->
    $service.cleanEmptyParams {
      page: $service.current_page
      per_page: $service.searchResultsData.pageSize
      providers: $service.getSearchParams()
      parent: $service.getCleanedParent()
    }

  $service.httpParams = ->
    {
      method: 'POST'
      url: '/api/providers'
      data: $service.queryParams()
    }

  $service.performSearch = (callback, page) =>
    that = $service
    that.searchResultsData.providers = []
    that.searchResultsData.isLoading = true
    params = that.httpParams()
    if page
      params.url += "?page=#{page}"
    serverRequestCallback = (response) ->
      if response.data
        that.searchResultsData.providers = response.data.content
        that.searchResultsData.totalNumProviders = response.data.totalElements
        that.searchResultsData.currentPage = response.data.number
        that.searchResultsData.isFirstPage = response.data.first
        that.searchResultsData.isLastPage = response.data.last
        that.searchResultsData.pageSize = response.data.size
      console.log 'in searchservice performSearch, the $service.filters are', $service.filters
      callback(response.data) if callback
      that.searchResultsData.isLoading = false

    searchParams = params.data.providers
    if searchParams.addresses
      GeocodingService.geocodeAddress(searchParams.addresses[0]).then (coords) =>
        searchParams.locationA = coords
        if searchParams.addresses[1]
          GeocodingService.geocodeAddress(searchParams.addresses[1]).then (coords) =>
            searchParams.locationB = coords
            $service.serverRequest(params, serverRequestCallback)
        else
          $service.serverRequest(params, serverRequestCallback)
    else
      $service.serverRequest(params, serverRequestCallback)

  $service.serverRequest = (params, callback) ->
    HttpService.http params, callback

  $service

SearchService.$inject = ['$http', '$cookies', 'CC_COOKIE', 'AgeInWeekToAgeGroupsService', 'VacancyDateService', 'DataService', 'GeocodingService', 'HttpService', '$rootScope']
angular.module('CCR').service('SearchService', SearchService)
