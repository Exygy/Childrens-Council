UserAccountController = ($timeout, $anchorScroll, $scope, $modal, $auth, $location) ->
  $ctrl = @
  $ctrl.$location = $location
  $ctrl.editing = false
  $ctrl.parent = $auth.currentUser()
  $ctrl.currentEmail = if $ctrl.parent then $ctrl.parent.email else null
  $ctrl.errors

  $ctrl.editUser = ->
    $ctrl.editing = true

  $ctrl.cancelEdit = ->
    $ctrl.editing = false

  sendUpdateRequest = () ->
    if !$ctrl.parent.phone
      $ctrl.parent.phone = ''
    $auth.updateAccount($ctrl.parent)
      .then (resp) ->
        $ctrl.parent = resp.data.data
        $ctrl.editing = false
        $ctrl.errors = []
        $ctrl.currentEmail = $ctrl.parent.email
      .catch (resp) ->
        $ctrl.errors = _.sortedUniq(resp.data.errors.full_messages)

  $ctrl.updateParent = () ->
    if $ctrl.currentEmail != $ctrl.parent.email
      modal = $modal.open {
        controller: 'userConfirmPasswordCtrl',
        templateUrl: 'user/confirm_password/confirm_password.html',
      }
      modal.result.then (params) ->
        if params['password']
          $ctrl.parent.current_password = params['password']
          sendUpdateRequest()
    else
      sendUpdateRequest()

  $scope.$on 'auth:validation-success', (event, parent) ->
    $ctrl.parent = parent
    $ctrl.currentEmail = $ctrl.parent.email

  $scope.$on 'auth:login-success', (event, parent) ->
    $ctrl.parent = parent
    $ctrl.currentEmail = $ctrl.parent.email

  $timeout $anchorScroll('account-content')

  return $ctrl

UserAccountController.$inject = ['$timeout', '$anchorScroll', '$scope', '$modal', '$auth', '$location']

angular
  .module('CCR')
  .component('account', {
    bindings:
      id: '<'
    controller: UserAccountController
    templateUrl: "user/user_account/user_account.html"
})
