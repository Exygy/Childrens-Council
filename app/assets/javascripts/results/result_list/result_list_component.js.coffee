ResultListController = () ->
  @resultsFromNum = ->
    (@data.currentPage * @data.pageSize) + 1

  @resultsToNum = ->
    (@data.currentPage + 1) * @data.pageSize

  return

angular
  .module('CCR')
  .component('resultList', {
    bindings:
      data: '<'
    controller: ResultListController
    templateUrl: "results/result_list/result_list.html"
  })
