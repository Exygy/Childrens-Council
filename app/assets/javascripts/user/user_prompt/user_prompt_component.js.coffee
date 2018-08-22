UserPromptController = ($scope, $modal) ->
  $ctrl = @

  $scope.login = () ->

  $scope.createAccount = ->
    $modal.open {
      controller: 'userRegisterCtrl',
      templateUrl: 'user/register/register.html',
      scope: $scope
    }

  return $ctrl

UserPromptController.$inject = ['$scope', '$modal']

angular
  .module('CCR')
  .component('userPrompt', {
    bindings:
      id: '<'
    controller: UserPromptController
    templateUrl: "user/user_prompt/user_prompt.html"
  })
