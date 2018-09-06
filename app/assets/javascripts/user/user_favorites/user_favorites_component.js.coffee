UserFavoritesController = ($timeout, $anchorScroll, $scope, FavoriteService) ->
  $ctrl = @
  $ctrl.favorites
  $ctrl.isLoading = true

  $ctrl.$onInit = () ->
    FavoriteService.getFavorites (data) ->
      $ctrl.favorites = data
      $ctrl.isLoading = false

  $timeout $anchorScroll('favorites-content')

  return $ctrl

UserFavoritesController.$inject = ['$timeout', '$anchorScroll', '$scope', 'FavoriteService']

angular
  .module('CCR')
  .component('favorites', {
    bindings:
      id: '<'
    controller: UserFavoritesController
    templateUrl: "user/user_favorites/user_favorites.html"
})
