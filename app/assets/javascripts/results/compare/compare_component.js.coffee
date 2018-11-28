CompareController = (CompareService, $window, $modal, $auth, $scope) ->
  $ctrl = @
  $ctrl.parent = $auth.currentUser()
  $ctrl.providersToCompare = CompareService.providersToCompare
  maxProvidersToCompare = 8

  $ctrl.addToComparisonAllowed = (checked) ->
    if $ctrl.parent
      return !checked || $ctrl.providersToCompare.length < maxProvidersToCompare
    else
      $modal.open {
        controller: 'userLoginCtrl',
        templateUrl: 'user/login/login.html',
      }
      return false

  $ctrl.alertIfComparisonMaxReached = (checked) ->
    if checked && $ctrl.providersToCompare.length >= maxProvidersToCompare
      $window.alert('You may select up to ' + maxProvidersToCompare + ' providers to compare at a time.')

  $scope.$on 'auth:validation-success', (event, user) ->
    $ctrl.parent = user

  $scope.$on 'auth:login-success', (event, user) ->
    $ctrl.parent = user

  return $ctrl

CompareController.$inject = ['CompareService', '$window', '$modal', '$auth', '$scope',]

angular
  .module('CCR')
  .component('compare', {
    bindings:
      provider: '<'
    controller: CompareController
    templateUrl: 'results/compare/compare.html'
  })
