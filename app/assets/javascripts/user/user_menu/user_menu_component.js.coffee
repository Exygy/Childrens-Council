UserMenuController = ($scope, $modal, $auth, $location) ->
  $ctrl = @
  $ctrl.$location = $location
  $ctrl.parent = $auth.currentUser()

  $ctrl.login = () ->
    $modal.open {
      controller: 'userLoginCtrl',
      templateUrl: 'user/login/login.html',
    }

  $ctrl.logout = () ->
    $auth.signOut()
      .then (resp) ->
        $ctrl.parent = null

  $scope.$on 'auth:validation-success', (event, user) ->
    $ctrl.parent = user

  $scope.$on 'auth:login-success', (event, user) ->
    $ctrl.parent = user


  return $ctrl

UserMenuController.$inject = ['$scope', '$modal', '$auth', '$location']

angular
  .module('CCR')
  .component('userMenu', {
  bindings:
    printText: '<'
  controller: UserMenuController
  templateUrl: "user/user_menu/user_menu.html"
})
