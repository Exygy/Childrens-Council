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
    care_reason_ids: ['']
    found_option_id: 0
    language_ids: ['']
    subscribe: 0
    children: [
      {
        age_months: 30,
        children_care_types_attributes: [
          { care_type_id: 1 }
        ]
        children_schedule_days_attributes: [
            { schedule_day_id: 2 },
            { schedule_day_id: 3 },
            { schedule_day_id: 4 },
            { schedule_day_id: 5 },
            { schedule_day_id: 6 }
          ] # Default to weekdays
        children_schedule_weeks_attributes: [
            { schedule_week_id: 1 }
          ] # Default to Full Time
        schedule_year_id: 1 # Default to Year Round
      }
    ]
  }

  @current_page = 1

  @getSearchParams = ->
    search_params = {}
    if @parent.children[0].age_months
      search_params['ages'] = [@parent.children[0].age_months]
    if @parent.children[0].children_care_types_attributes.length and @parent.children[0].children_care_types_attributes[0].length
      search_params['care_type_ids'] = @parent.children[0].children_care_types_attributes
    if @parent.language_ids.length and @parent.language_ids[0].length
      search_params['language_ids'] = @parent.language_ids
    if @parent.children[0].children_schedule_days_attributes.length
      search_params['schedule_day_ids'] = @parent.children[0].children_schedule_days_attributes
    if @parent.children[0].children_schedule_weeks_attributes.length
      search_params['schedule_week_ids'] = @parent.children[0].children_schedule_weeks_attributes
    if @parent.children[0].schedule_year_id
      search_params['schedule_year_ids'] = [@parent.children[0].schedule_year_id]
    if @parent[@settings.location_type].length
      search_params[@settings.location_type] = @parent[@settings.location_type]
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
      parent: @parent
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
