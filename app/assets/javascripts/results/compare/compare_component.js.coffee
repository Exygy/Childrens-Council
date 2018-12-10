CompareToggleController = (ProviderService, $window, $modal, $auth, $scope) ->
  $ctrl = @
  $ctrl.parent = $auth.currentUser()
  $ctrl.providerIdsToCompare = ProviderService.providerIdsToCompare
  maxprovidersToCompare = 8

  $ctrl.addToComparisonAllowed = (checked) ->
    if $ctrl.parent
      return !checked || $ctrl.providerIdsToCompare.length < maxprovidersToCompare
    else
      $modal.open {
        controller: 'userLoginCtrl',
        templateUrl: 'user/login/login.html',
      }
      return false

  $ctrl.alertIfComparisonMaxReached = (checked) ->
    if checked && $ctrl.providerIdsToCompare.length >= maxprovidersToCompare
      $window.alert('You may select up to ' + maxprovidersToCompare + ' providers to compare at a time.')

  $scope.$on 'auth:validation-success', (event, user) ->
    $ctrl.parent = user

  $scope.$on 'auth:login-success', (event, user) ->
    $ctrl.parent = user

  return $ctrl

CompareToggleController.$inject = ['ProviderService', '$window', '$modal', '$auth', '$scope',]

angular
  .module('CCR')
  .component('compareToggle', {
    bindings:
      provider: '<'
    controller: CompareToggleController
    templateUrl: 'results/compare/compare_toggle.html'
  })
