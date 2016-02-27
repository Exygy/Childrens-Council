DataService = (HttpService) ->
  @data = {
    totalProviders: 0,
    providersPerPage: 25,
    providers: [],
  }

  @parent = {
    fullName: ''
    email: ''
    phone: ''
  }

  @search_params = {
    near_address: ''
  }

  @current_page = 1

  @queryParams = ->
    {
      page: @current_page,
      per_page: @providersPerPage,
      providers: @search_params,
      parent: @parent,
    }

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
