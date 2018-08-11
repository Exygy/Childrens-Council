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
    if @searchSettings.locationType == 'address'
      if params.address and params.address.indexOf(', San Francisco, CA') == -1
        params.address += ', San Francisco, CA'
    else if @searchSettings.locationType == 'zipCodes'
      # We are allowing users to select multiple zip codes in the form,
      # but the NDS API does not yet support searching by multiple zip
      # codes, so we are passing through just the first selected zip code
      # for now. We are keeping the form as-is because we believe the API
      # will be updated to allow searching by multiple zip codes by the
      # time we make this app live.
      params.zip = params.zipCodes[0]
      delete params.address
    else if @searchSettings.locationType == 'neighborhoods'
      params.attributesLocal17 = params.neighborhoods
      delete params.address

    delete params.neighborhoods
    delete params.zipCodes

  @setTypeOfCare = (params) ->
    if params.typeOfCare.length == 1
      params.typeOfCare = params.typeOfCare[0]
    else if params.typeOfCare.length == 2
      # We are allowing users to select multiple types of care in the
      # form, but the NDS API does not yet support searching by multiple
      # types of care. So if the user selects both types of care (there
      # are only two types), we convey that to the API as no selection
      # for type of care, so that the API will search over all types of
      # care. This functions correctly, but is semantically a bit odd. We
      # believe that the API will be updated to allow searching by multiple
      # types of care by the time we make this app live.
      delete params.typeOfCare

  # The API field used to search for care approaches and religious programs
  # is the same, so we concatenate these names into a single list.
  @setPrograms = (params) ->
    params.generalLocal2 = []

    if params.careApproaches.length && params.careApproaches[0]
      params.generalLocal2 = params.generalLocal2.concat(params.careApproaches)

    if params.religiousPrograms.length && params.religiousPrograms[0]
      params.generalLocal2 = params.generalLocal2.concat(params.religiousPrograms)

    delete params.careApproaches
    delete params.religiousPrograms
    delete params.generalLocal2 if !params.generalLocal2.length

  @setEnvironments = (params) ->
    if params.pottyTraining
      params.environments = [params.pottyTraining]

    delete params.pottyTraining

  @buildParent = ->
    @parent.parents_care_types = @filters.typeOfCare.map (type) -> { 'type': type }

  @getSearchParams = ->
    @buildParent()
    search_params = angular.copy @filters

    # those params should be children specific when the feature is built
    search_params.ageGroupServiced = @parent.children[0].age_weeks
    search_params.yearlySchedule = @parent.children[0].yearlySchedule
    search_params.weeklySchedule = @parent.children[0].weeklySchedule.map((day) -> day.toUpperCase())
    # TODO: set shift info in params
    # search_params.schedule_week_ids = @parent.children[0].schedule_week_ids

    @setSearchLocation(search_params)
    @setTypeOfCare(search_params)
    @setPrograms(search_params)
    @setEnvironments(search_params)

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
      delete parent.children[index].schedule_week_ids
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
