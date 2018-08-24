UserPromptController = ($scope, $modal, $auth) ->
  $ctrl = @
  $scope.parent

  $scope.login = () ->
    $modal.open {
      controller: 'userLoginCtrl',
      templateUrl: 'user/login/login.html',
    }

  $scope.createAccount = ->
    $modal.open {
      controller: 'userRegisterCtrl',
      templateUrl: 'user/register/register.html',
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
