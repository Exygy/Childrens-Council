FavoriteService = (HttpService) ->

  @getFavorites = (callback) ->
    that = @
    HttpService.http(
      { method: 'GET', url: '/api/favorites' },
      (response) ->
        if callback
          callback(response.data)

      (error) ->
        console.log("ERROR")
        console.log(error)
    )

  @createFavorite = (id, callback) ->
    that = @
    HttpService.http(
      { method: 'POST', url: '/api/favorites', data: {favorite: {provider_id: id}} },
      (response) ->
        if callback
          callback(response.data)

      (error) ->
        console.log("ERROR")
        console.log(error)
    )

  @destroyFavorite = (id, callback) ->
    that = @
    HttpService.http(
      { method: 'DELETE', url: '/api/favorites/'+ id },
      (response) ->
        if callback
          callback(response.data)

      (error) ->
        console.log("ERROR")
        console.log(error)
    )
  return @

FavoriteService.$inject = ['HttpService']
angular.module('CCR').service('FavoriteService', FavoriteService)
