UserNavigationController = ($location) ->
  $ctrl = @
  $ctrl.$location = $location
  return $ctrl

UserNavigationController.$inject = ['$location']

angular
  .module('CCR')
  .component('userNav', {
    bindings:
      id: '<'
    controller: UserNavigationController
    templateUrl: "user/user_navigation/user_navigation.html"
})
