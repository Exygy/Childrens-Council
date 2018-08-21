RegisterController = ($scope, Auth) ->
  $ctrl = @

  # credentials = {
  #     email: 'user@domain.com',
  #     password: 'password1',
  #     password_confirmation: 'password1'
  # }
  $scope.register = ->
    Auth.register($scope.registerForm).then (registeredUser) ->
        console.log(registeredUser);
    (error) ->
      # Registration failed...
      return

  $scope.$on 'devise:new-registration', (event, user) ->
    console.log(event, user)

  return $ctrl

RegisterController.$inject = ['$scope', 'Auth']

angular
  .module('CCR')
  .controller('userRegisterCtrl', RegisterController)
