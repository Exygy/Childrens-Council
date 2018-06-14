MealsController = ->
  $ctrl = @

  @$onInit = () ->
    return

  return @

MealsController.$inject = []

angular
  .module('CCR')
  .component('meals', {
    bindings:
      provider: '<'
    controller: MealsController
    templateUrl: "provider/meals/meals.html"
  })
