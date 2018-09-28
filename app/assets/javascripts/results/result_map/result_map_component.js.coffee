ResultMapController = () ->
  return

angular
  .module('CCR')
  .component('resultMap', {
    bindings:
      data: '<'
    controller: ResultMapController
    templateUrl: "results/result_map/result_map.html"
  })
