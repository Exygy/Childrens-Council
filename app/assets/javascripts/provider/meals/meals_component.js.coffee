MealsController = (LocationService) ->
  $ctrl = @

  @$onInit = () ->
    $ctrl.provider = LocationService.mapify($ctrl.provider)
    return

  return @

MealsController.$inject = ['LocationService']

angular
  .module('CCR')
  .component('meals', {
    bindings:
      provider: '<'
    controller: MealsController
    templateUrl: "/assets/provider/meals/meals.html"
  })
