LocationController = ->
  $ctrl = @

  @$onInit = () ->
    return

  return @

LocationController.$inject = []

angular
  .module('CCR')
  .component('location', {
    bindings:
      provider: '<'
    controller: LocationController
    templateUrl: "provider/location/location.html"
  })
