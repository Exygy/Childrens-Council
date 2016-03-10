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
  }

  @search_params = {
    near_address: '',
    care_type_ids: [],
    neighborhood_ids: [''],
    zip_code_ids: [''],
  }

  @current_page = 1

  @queryParams = ->
    params = {
      page: @current_page,
      per_page: @providersPerPage,
      providers: @search_params,
      parent: @parent,
    }

    deepFilter params, (value) ->
      # Filter out empty strings and arrays
      if typeof value.length != 'undefined' and value.length <= 0 then false else true

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
