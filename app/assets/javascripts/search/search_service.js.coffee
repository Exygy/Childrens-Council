SearchService = ($http, $cookies, CC_COOKIE, DataService, GeocodingService, HttpService) ->
  @filterData = DataService.filterData
  @filters = DataService.filters
  @parent = DataService.parent
  @searchSettings = DataService.searchSettings
  @searchResultsData = DataService.searchResultsData

  @deleteApiKey = ->
    $cookies.remove CC_COOKIE

  @postSearch = (callback, opts = {}) ->
    if opts.deleteApiKey
      # reset API KEY == enforce parent authentication
      @deleteApiKey()

    if opts.reset
      # in case search fails - will display no results
      DataService.resetData()

    # search
    DataService.current_page = 1
    @performSearch callback

  # Rename location params to NDS API names, and ensure addresses have SF in them.
  @setSearchLocation = (params) ->
    if @searchSettings.locationType == 'address' && params.address
      if params.address.indexOf(', San Francisco, CA') == -1
        params.address += ', San Francisco, CA'
      params.distance = 2 # set the search radius in miles
    else if @searchSettings.locationType == 'zipCodes' && params.zipCodes.length && params.zipCodes[0].length
      params.zip = params.zipCodes
      delete params.address
    else if @searchSettings.locationType == 'neighborhoods' && params.neighborhoods.length && params.neighborhoods[0].length
      params.attributesLocal17 = params.neighborhoods
      delete params.address

    delete params.neighborhoods
    delete params.zipCodes

  # Reformat and rename program params to match API fields.
  @setPrograms = (params) ->
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

  @setEnvironments = (params) ->
    if params.pottyTraining
      params.environments = [params.pottyTraining]

    delete params.pottyTraining

  @setAgeGroup = (params) ->
    if params.ageGroupServiced
      weeks = params.ageGroupServiced
      params.ageGroup = switch
        # 0 yrs to 1 yr 11 mos
        when weeks >= 0 && weeks < 102 then 'INFANT_1'
        # 2 yrs to 5 yrs 11 mos
        when weeks >= 102 && weeks < 312 then 'PRESCHOOL_1'
        # 6 yrs and up
        when weeks >= 312 then 'SCHOOL_1'
        # The value "SCHOOL_2" represents all ages
        else
          'SCHOOL_2'

  @setMonthlyRate = (params) ->
    if params.monthlyRate
      params.monthlyRate =
        from: params.monthlyRate[0]
        to: params.monthlyRate[1]

  @setVacancies = (params) ->
    # TODO: configure params to search the API for provider vacancies
    delete params.vacancyType
    delete params.vacancyFutureDate

  @buildParent = ->
    @parent.parents_care_types = @filters.typeOfCare.map (type) -> { 'type': type }

  @getSearchParams = ->
    @buildParent()
    search_params = angular.copy @filters

    # those params should be children specific when the feature is built
    search_params.ageGroupServiced = @parent.children[0].ageWeeks
    search_params.yearlySchedule = @parent.children[0].yearlySchedule
    search_params.weeklySchedule = @parent.children[0].weeklySchedule.map((day) -> day.toUpperCase())

    # TODO: set shift info in params
    # @setShiftParams(search_params)
    @setSearchLocation(search_params)
    @setPrograms(search_params)
    @setEnvironments(search_params)
    @setAgeGroup(search_params)
    @setMonthlyRate(search_params)
    @setVacancies(search_params)

    search_params

  @cleanEmptyParams = (params) ->
    deepFilter params, (value, key) ->
      # Filter out empty values and arrays
      if !value? or (Array.isArray(value) and (value.length == 0 or value[0] == '')) then false else true

  @getCleanedParent = ->
    parent = angular.copy @parent
    delete parent.care_type_ids
    delete parent.agree
    for child, index in parent.children
      delete parent.children[index].weeklySchedule
      delete parent.children[index].shiftFeatures
      delete parent.children[index].selected
    parent

  @queryParams = ->
    @cleanEmptyParams {
      page: @current_page
      per_page: @searchResultsData.pageSize
      providers: @getSearchParams()
      parent: @getCleanedParent()
    }

  @httpParams = ->
    {
      method: 'POST'
      url: '/api/providers'
      data: @queryParams()
    }

  @performSearch = (callback, page) =>
    that = @
    that.searchResultsData.providers = []
    that.searchResultsData.isLoading = true
    params = @httpParams()
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
      callback(response.data) if callback
      that.searchResultsData.isLoading = false

    searchParams = params.data.providers
    if searchParams.address
      GeocodingService.geocodeAddress(searchParams.address).then (coords) =>
        searchParams.locationA = coords
        delete searchParams.address
        @serverRequest(params, serverRequestCallback)
    else
      @serverRequest(params, serverRequestCallback)

  @serverRequest = (params, callback) ->
    HttpService.http params, callback

  @

SearchService.$inject = ['$http', '$cookies', 'CC_COOKIE', 'DataService', 'GeocodingService', 'HttpService']
angular.module('CCR').service('SearchService', SearchService)
