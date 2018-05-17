BadgeController = (BadgeService) ->
  $ctrl = @

  @$onInit = () ->
    $ctrl.url = BadgeService.url($ctrl.name)

  return @

BadgeController.$inject = ['BadgeService']

angular
  .module('CCR')
  .component('badge', {
    bindings:
      name: '<'
    controller: BadgeController
    templateUrl: "badge/badge.html"
  })
