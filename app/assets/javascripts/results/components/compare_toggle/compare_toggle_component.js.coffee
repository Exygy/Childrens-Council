CompareToggleController = (CompareService, $window, $modal, $auth, $scope) ->
  $ctrl = @
  $ctrl.parent = $auth.currentUser()
  $ctrl.providerIdsToCompare = CompareService.data.providerIds
  maxProvidersToCompare = CompareService.maxProvidersToCompare

  $ctrl.onCompareClick = () ->
    if !$ctrl.parent
      $modal.open {
        controller: 'userLoginCtrl',
        templateUrl: 'user/login/login.html',
      }

  $ctrl.addToComparisonAllowed = (checked) ->
    if $ctrl.parent
      !checked || $ctrl.providerIdsToCompare.length < maxProvidersToCompare
    else
      false

  $ctrl.alertIfComparisonMaxReached = (checked) ->
    if checked && $ctrl.providerIdsToCompare.length >= maxProvidersToCompare
      $window.alert('You may select up to ' + maxProvidersToCompare + ' providers to compare at a time.')

  $scope.$on 'auth:validation-success', (event, user) ->
    $ctrl.parent = user

  $scope.$on 'auth:login-success', (event, user) ->
    $ctrl.parent = user

  return $ctrl

CompareToggleController.$inject = ['CompareService', '$window', '$modal', '$auth', '$scope']

angular
  .module('CCR')
  .component('compareToggle', {
    bindings:
      provider: '<'
    controller: CompareToggleController
    templateUrl: 'results/components/compare_toggle/compare_toggle.html'
  })
