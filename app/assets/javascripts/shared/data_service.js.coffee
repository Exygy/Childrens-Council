DataService = ($rootScope, HttpService) ->
  @data = {
    totalProviders: 0
    providersPerPage: 25
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
    neighborhood_ids: ['']
    zip_code_ids: ['']
    found_option_id: 0
    language_ids: ['']
    subscribe: 0
    parents_care_reasons_attributes: ['']
    children: [
      {
        age_months: null,
        children_care_types_attributes: []
        children_schedule_days_attributes: []
        children_schedule_weeks_attributes: []
        schedule_year_id: null # Default to Year Round
      }
    ]
  }

  @filters = {
    age_months: 30
    care_reason_ids: ['']
    care_type_ids: []
    schedule_day_ids: [2,3,4,5,6] # Default to weekdays
    schedule_week_ids: [1] # Default to Full Time
    schedule_year_id: [1]
  }

  @current_page = 1

  @getParent = ->
    # build Parent obj

    # @parent.language_ids = @filters.language_ids

    @parent[@settings.location_type] = @filters[@settings.location_type]

    # build children[0]
    @parent.children[0].schedule_year_id = @filters.schedule_year_id[0]
    @parent.children[0].age_months = @filters.age_months

    @parent.children[0].children_care_types_attributes = []
    for care_type_id in @filters.care_type_ids
      @parent.children[0].children_care_types_attributes.push { care_type_id: care_type_id }

    @parent.children[0].children_schedule_days_attributes = []
    for schedule_day_id in @filters.schedule_day_ids
      @parent.children[0].children_schedule_days_attributes.push { schedule_day_id: schedule_day_id }

    @parent.children[0].children_schedule_weeks_attributes = []
    for schedule_week_id in @filters.schedule_week_ids
      @parent.children[0].children_schedule_weeks_attributes.push { schedule_week_id: schedule_week_id }

    @parent


  @getSearchParams = ->
    search_params = @filters
    search_params[@settings.location_type] = @filters[@settings.location_type]
    search_params

  @cleanEmptyParams = (params) ->
    deepFilter params, (value, key) ->
      # Filter out empty strings and arrays
      if (value and value.length <= 0) or value[0] == '' then false else true

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
