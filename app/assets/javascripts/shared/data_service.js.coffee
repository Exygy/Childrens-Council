DataService = (HttpService) ->
  @data = {
    totalProviders: 0,
    providersPerPage: 25,
    providers: [],
  }

  @parent = {
    full_name: ''
    email: ''
    phone: ''
    children: [
      {
        age: 30
      },
    ]
  }

  @search_params = {
    care_type_ids: [],
    location_type: '',
    near_address: '',
    neighborhood_ids: [''],
    zip_code_ids: [''],
  }

  @current_page = 1

  @getSearchParams = ->
    search_params = @search_params
    search_params.ages = []

    @parent.children.forEach (child) ->
      search_params.ages.push(child.age)

    # Remove unneeded search params
    keys_to_remove = [
      'location_type',
      'near_address',
      'neighborhood_ids',
      'zip_code_ids',
    ].filter (value) ->
      value != search_params.location_type

    _.transform search_params, (filtered_params, value, key) ->
      filtered_params[key] = value unless key in keys_to_remove
    , {}


  @queryParams = ->
    params = {
      page: @current_page,
      per_page: @data.providersPerPage,
      providers: @getSearchParams(),
      parent: @parent,
    }

    deepFilter params, (value) ->
      # Filter out empty strings and arrays
      if value and value.length <= 0 then false else true

  @httpParams = ->
    {
      method: 'POST',
      url: '/api/providers',
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
    HttpService.http( @httpParams(), callback )

  @resetData = ->
    @data.providers = []
    @data.totalProviders = 0

  @

DataService.$inject = ['HttpService']
angular.module('CCR').service('DataService', DataService)
