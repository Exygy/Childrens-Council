FavoriteController = (FavoriteService, $modal, $auth, $scope) ->
  $ctrl = @
  $ctrl.favorited = $ctrl.provider.favorite
  $ctrl.parent = $auth.currentUser()

  $ctrl.favorite = ->
    if $ctrl.parent
      FavoriteService.createFavorite($ctrl.provider.providerId, $ctrl.handleFavorite)
    else
      $modal.open {
        controller: 'userLoginCtrl',
        templateUrl: 'user/login/login.html',
      }

  $ctrl.handleFavorite = ->
    $ctrl.favorited = true

  $ctrl.unFavorite = ->
    FavoriteService.destroyFavorite($ctrl.provider.providerId, $ctrl.handleUnFavorite)

  $ctrl.handleUnFavorite = ->
    $ctrl.favorited = false

  $scope.$on 'auth:validation-success', (event, user) ->
    $ctrl.parent = user

  $scope.$on 'auth:login-success', (event, user) ->
    $ctrl.parent = user

  return $ctrl

FavoriteController.$inject = ['FavoriteService', '$modal', '$auth', '$scope',]

angular
  .module('CCR')
  .component('favorite', {
    bindings:
      provider: '<'
    controller: FavoriteController
    templateUrl: "provider/favorite/favorite.html"
  })
