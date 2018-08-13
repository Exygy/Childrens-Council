ResultMapController = () ->
  @resultsFromNum = ->
    (@data.currentPage * @data.pageSize) + 1

  @resultsToNum = ->
    (@data.currentPage + 1) * @data.pageSize

  return

angular
  .module('CCR')
  .component('resultMap', {
    bindings:
      data: '<'
    controller: ResultMapController
    templateUrl: "results/result_map/result_map.html"
  })
