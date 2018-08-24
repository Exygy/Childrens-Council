UserPromptController = ($scope, $modal, $auth) ->
  $ctrl = @
  $scope.parent

  $scope.login = () ->

  $scope.createAccount = ->
    $modal.open {
      controller: 'userRegisterCtrl',
      templateUrl: 'user/register/register.html',
      scope: $scope
    }

  $scope.$on 'auth:validation-success', (event, user) ->
    $scope.parent = user

  $scope.$on 'auth:login-success', (event, user) ->
    $scope.parent = user


  return $ctrl

UserPromptController.$inject = ['$scope', '$modal', '$auth']

angular
  .module('CCR')
  .component('userPrompt', {
    bindings:
      id: '<'
    controller: UserPromptController
    templateUrl: "user/user_prompt/user_prompt.html"
  })
