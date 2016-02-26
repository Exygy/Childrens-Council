SearchService = ($http) ->
  @data = {
    totalProviders: 0,
    providersPerPage: 25,
    providers: [],
  }

  @parent = {
    firstName: ''
    lastName: ''
    email: ''
    phone: ''
  }

  @search_params = {
    near_address: ''
  }

  @current_page = 1

  @ParentIsValid = ->
    @parent.firstName != '' and @parent.lastName != '' and ( @parent.email != '' or @parent.phone != '' )

  @queryParams = ->
    {
      page: @current_page,
      per_page: @providersPerPage,
      providers: @search_params,
      parent: @parent,
    }

  @postSearch = (callback) ->
    that = @
    @current_page = 1
    @serverRequest (response) ->
      that.data.providers = response.data.providers
      that.data.totalProviders = response.data.total
      callback() if callback

  @nextPage = (callback) ->
    that = @
    @current_page++
    @serverRequest (response) ->
      that.data.providers = response.data.providers
      that.data.totalProviders = response.data.total
      callback() if callback

  @prevPage = (callback) ->
    that = @
    @current_page--
    @serverRequest (response) ->
      that.data.providers = response.data.providers
      that.data.totalProviders = response.data.total
      callback() if callback


  @serverRequest = (callback) ->
    that = @
    $http {
      method: 'POST',
      url: '/api/providers',
      data: @queryParams()
    }
    .then (response) ->
      # this callback will be called asynchronously
      # when the response is available
      callback(response) if callback
  @

SearchService.$inject = ['$http']
angular.module('CCR').service('SearchService', SearchService)
