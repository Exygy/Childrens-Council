RegisterController = ($scope, $auth, DataService) ->
  $ctrl = @
#  $scope.parent = DataService.parent
#  $scope.registerForm

  # credentials = {
  #     email: 'user@domain.com',
  #     password: 'password1',
  #     password_confirmation: 'password1'
  # }
  $scope.register = (parent) ->
    window.console.log('test')
    $auth.submitRegistration(parent)
      .then (resp) ->
        return
      .catch (resp) ->
        return
#    // handle success response
#    })
#    .catch(function(resp) {
#    // handle error response
#    });
#  };
#    Auth.register($scope.registerForm).then (registeredUser) ->
#        console.log(registeredUser);
#    (error) ->
#      # Registration failed...
#      return

  $scope.$on 'devise:new-registration', (event, user) ->
    console.log(event, user)

  return $ctrl

RegisterController.$inject = ['$scope', '$auth', 'DataService']

angular
  .module('CCR')
  .controller('userRegisterCtrl', RegisterController)
