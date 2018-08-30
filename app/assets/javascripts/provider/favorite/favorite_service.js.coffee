FavoriteService = (HttpService) ->
  @create = (id, callback) ->
    that = @
    HttpService.http(
      { method: 'POST', url: '/api/favorites' },
      (response) ->
        if callback
          callback(response.data)

      (error) ->
        console.log("ERROR")
        console.log(error)
    )
  @destroy = (id, callback) ->
    that = @
    HttpService.http(
      { method: 'DELETE', url: '/api/favorites/'+id },
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
