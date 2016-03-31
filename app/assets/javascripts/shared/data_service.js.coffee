DataService = ($rootScope, HttpService) ->
  @data = {
    totalProviders: 0
    providersPerPage: 15
    providers: []
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
        children_care_types_attributes: []
        children_schedule_days_attributes: []
        children_schedule_weeks_attributes: []
        schedule_year_id: null
      }
    ]
  }

  @filters = {
    age_months: 30
    care_type_ids: null
    near_address: null
    co_op: null
    nutrition_program: null
    potty_training: null
    language_ids: ['']
    program_ids: ['']
    subsidy_ids: ['']
    religion_ids: ['']
    care_approach_ids: ['']
    neighborhood_ids: ['']
    schedule_day_ids: [2,3,4,5,6] # Default to weekdays
    schedule_week_ids: [1] # Default to Full Time
    schedule_year_id: 1 # Default to Year Round
    zip_code_ids: ['']
  }

  @current_page = 1

  @getLocation = ->
    if @settings.location_type == 'near_address'
      if @filters.near_address then @filters.near_address + ', San Francisco, CA' else null
    else
      @filters[@settings.location_type]

  @getParent = ->
    # build Parent obj

    # @parent.language_ids = @filters.language_ids
    @parent.near_address = @filters.near_address

    # build children_attributes
    @parent.children_attributes[0].schedule_year_id = @filters.schedule_year_id[0]
    @parent.children_attributes[0].age_months = @filters.age_months

    if @filters.care_type_ids
      @parent.children_attributes[0].children_care_types_attributes = []
      for care_type_id in @filters.care_type_ids
        @parent.children_attributes[0].children_care_types_attributes.push { care_type_id: care_type_id }
    if @filters.schedule_day_ids
      @parent.children_attributes[0].children_schedule_days_attributes = []
      for schedule_day_id in @filters.schedule_day_ids
        @parent.children_attributes[0].children_schedule_days_attributes.push { schedule_day_id: schedule_day_id }
    if @filters.schedule_week_ids
      @parent.children_attributes[0].children_schedule_weeks_attributes = []
      for schedule_week_id in @filters.schedule_week_ids
        @parent.children_attributes[0].children_schedule_weeks_attributes.push { schedule_week_id: schedule_week_id }

    @parent

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
    # this function should not exist, it temporarly exists until we get to filters by many children feature
    search_params = {}
    search_params.ages = [@filters.age_months]
    search_params.care_type_ids = @filters.care_type_ids
    search_params.language_ids = @filters.language_ids
    search_params.schedule_day_ids = @filters.schedule_day_ids
    search_params.schedule_week_ids = @filters.schedule_week_ids
    search_params.schedule_year_ids = [@filters.schedule_year_id]
    search_params.co_op = @filters.co_op
    search_params.nutrition_program = @filters.nutrition_program
    search_params.potty_training = @filters.potty_training
    search_params.subsidy_ids = @filters.subsidy_ids
    search_params.program_ids = @concatProgramsIds()
    search_params[@settings.location_type] = @getLocation()
    search_params

  @cleanEmptyParams = (params) ->
    deepFilter params, (value, key) ->
      # Filter out empty values and arrays
      if !value? or (Array.isArray(value) and (value.length == 0 or value[0] == '')) then false else true

  @queryParams = ->
    @cleanEmptyParams {
      page: @current_page
      per_page: @data.providersPerPage
      providers: @getSearchParams()
      parent: @getParent()
    }

  @httpParams = ->
    {
      method: 'POST'
      url: '/api/providers'
      data: @queryParams()
    }

  @performSearch = (callback) =>
    that = @
    @serverRequest (response) ->
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
