FavoriteController = ->
  @favorited = false
  return @

FavoriteController.$inject = []

angular
  .module('CCR')
  .component('favorite', {
    bindings:
      provider: '<'
    controller: FavoriteController
    templateUrl: "provider/favorite/favorite.html"
  })
