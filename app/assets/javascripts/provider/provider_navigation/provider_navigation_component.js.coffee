ProviderNavigationController = ($timeout) ->
  $ctrl = @

  $ctrl.$onInit = () ->
    $timeout () ->
      $ctrl.initFoundation()
    $timeout () ->
      $ctrl.setSideNavWidth()

  $ctrl.initFoundation = ->
    $(document).foundation {
      'magellan-expedition': {
        threshold: 0
        destination_threshold: 50
        offset_by_height: false
      }
    }

  $ctrl.setSideNavWidth = ->
    $side_nav = $('[data-magellan-expedition]')
    $side_nav.width $side_nav.parents('.columns').width() if $side_nav.length

  return @

ProviderNavigationController.$inject = ['$timeout']

angular
  .module('CCR')
  .component('providerNavigation', {
    bindings:
      provider: '<'
    controller: ProviderNavigationController
    templateUrl: "provider/provider_navigation/provider_navigation.html"
  })
