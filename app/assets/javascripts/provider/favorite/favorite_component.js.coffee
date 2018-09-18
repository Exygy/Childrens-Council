FavoriteController = (FavoriteService, $modal, $auth, $scope) ->
  $ctrl = @
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
    $ctrl.provider.favorite = true

  $ctrl.unFavorite = ->
    if $ctrl.parent
      FavoriteService.destroyFavorite($ctrl.provider.providerId, $ctrl.handleUnFavorite)
    else
      $modal.open {
        controller: 'userLoginCtrl',
        templateUrl: 'user/login/login.html',
      }

  $ctrl.handleUnFavorite = ->
    $ctrl.provider.favorite = false

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
