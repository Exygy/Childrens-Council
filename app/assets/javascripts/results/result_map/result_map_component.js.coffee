ResultMapController = () ->
  return

angular
  .module('CCR')
  .component('resultMap', {
    bindings:
      data: '<'
      addresses: '<'
    controller: ResultMapController
    templateUrl: "results/result_map/result_map.html"
  })
