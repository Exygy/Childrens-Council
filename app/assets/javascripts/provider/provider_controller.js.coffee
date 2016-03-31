ProviderController = ($scope, $state, ProviderService, _, FOUNDATION_SETTINGS) ->
  $scope.provider = ProviderService.provider
  $scope.provider.map = ProviderService.providerMap($scope.provider)

  # Initialize foundation js plugins and set width for sticky sidebar nav
  $scope.$on '$viewContentLoaded', (event) ->
    $(document).foundation(FOUNDATION_SETTINGS)
    setSideNavWidth()
    $(window).on 'resize', _.debounce(setSideNavWidth, 400)

ProviderController.$inject = ['$scope', '$state', 'ProviderService', '_', 'FOUNDATION_SETTINGS']
angular.module('CCR').controller('ProviderController', ProviderController)

setSideNavWidth = ->
  $side_nav = $('[data-magellan-expedition]')
  $side_nav.width $side_nav.parents('.columns').width()
