BadgeController = (BadgeService) ->
  $ctrl = @

  @$onInit = () ->
    $ctrl.tooltip = BadgeService.tooltip($ctrl.name)
    $ctrl.url = BadgeService.url($ctrl.name)

  return @

BadgeController.$inject = ['BadgeService']

angular
  .module('CCR')
  .component('badge', {
    bindings:
      name: '<'
    controller: BadgeController
    templateUrl: "badges/badge/badge.html"
  })
