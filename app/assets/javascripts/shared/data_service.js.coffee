DataService = ($rootScope, HttpService) ->
  @data = {
    totalProviders: 0
    providersPerPage: 15
    providers: []
    is_loading: false
  }

  @settings = {
    location_type: ''
  }

  @parent = {
    full_name: ''
    email: ''
    phone: ''
    home_zip_code: ''
    near_address: ''
    agree: false
    subscribe: false
    found_option_id: null
    parents_care_reasons_attributes: ['']
    children_attributes: [
      {
        age_months: 30,
        care_type_ids: null
        children_care_types_attributes: []
        schedule_day_ids: [2,3,4,5,6]
        children_schedule_days_attributes: []
        schedule_week_ids: [1]
        children_schedule_weeks_attributes: []
        schedule_year_id: 1
        selected: true
      }
    ]
  }

  @filters = {
    near_address: null
    co_op: null
    meals_included: null
    potty_training: null
    language_ids: ['']
    program_ids: ['']
    subsidy_ids: []
    religion_ids: ['']
    care_approach_ids: ['']
    neighborhood_ids: ['']
    zip_code_ids: ['']
  }

  @current_page = 1

  @getLocation = ->
    if @settings.location_type == 'near_address'
      if @filters.near_address and @filters.near_address.indexOf(', San Francisco, CA') == -1
        @filters.near_address + ', San Francisco, CA'
      else
        @filters.near_address
    else
      @filters[@settings.location_type]

  @buildChildren = ->
    for child, index in @parent.children_attributes
      @parent.children_attributes[index].children_care_types_attributes = []
      if child.care_type_ids
        for care_type_id in child.care_type_ids
          @parent.children_attributes[index].children_care_types_attributes.push { care_type_id: care_type_id }

      @parent.children_attributes[index].children_schedule_days_attributes = []
      if child.schedule_day_ids
        for schedule_day_id in child.schedule_day_ids
          @parent.children_attributes[index].children_schedule_days_attributes.push { schedule_day_id: schedule_day_id }

      @parent.children_attributes[index].children_schedule_weeks_attributes = []
      if child.schedule_week_ids
        for schedule_week_id in child.schedule_week_ids
          @parent.children_attributes[index].children_schedule_weeks_attributes.push { schedule_week_id: schedule_week_id }

  @concatProgramsIds = ->
    program_ids = []
    if @filters.program_ids.length and @filters.program_ids[0] != ''
      program_ids = program_ids.concat @filters.program_ids
    if @filters.religion_ids.length and @filters.religion_ids[0] != ''
      program_ids = program_ids.concat @filters.religion_ids
    if @filters.care_approach_ids.length and @filters.care_approach_ids[0] != ''
      program_ids = program_ids.concat @filters.care_approach_ids
    program_ids

  @getSearchParams = ->
    @buildChildren()
    search_params = @filters
    search_params.program_ids = @concatProgramsIds()
    search_params[@settings.location_type] = @getLocation()
    search_params

  @cleanEmptyParams = (params) ->
    deepFilter params, (value, key) ->
      # Filter out empty values and arrays
      if !value? or (Array.isArray(value) and (value.length == 0 or value[0] == '')) then false else true

  @getCleanedParent = ->
    parent = angular.copy @parent
    delete parent.agree
    for child, index in parent.children_attributes
      delete parent.children_attributes[index].schedule_day_ids
      delete parent.children_attributes[index].schedule_week_ids
      delete parent.children_attributes[index].selected
      # delete parent.children_attributes[index].care_type_ids
    parent

  @queryParams = ->
    @cleanEmptyParams {
      page: @current_page
      per_page: @data.providersPerPage
      providers: @getSearchParams()
      parent: @getCleanedParent()
    }

  @httpParams = ->
    {
      method: 'POST'
      url: '/api/providers'
      data: @queryParams()
    }

  @performSearch = (callback) =>
    that = @
    that.data.providers = []
    that.data.is_loading = true
    @serverRequest (response) ->
      that.data.is_loading = false
      if response.data
        that.data.providers = response.data.providers
        that.data.totalProviders = response.data.total
        that.data.current_page = that.current_page
      callback() if callback

  @serverRequest = (callback) ->
    HttpService.http @httpParams(), callback

  @resetData = ->
    @data.providers = []
    @data.totalProviders = 0

  @

DataService.$inject = ['$rootScope', 'HttpService']
angular.module('CCR').service('DataService', DataService)
