ResultPagerController = ($anchorScroll, ResultsService) ->
  $ctrl = @

  $ctrl.nextPage = ->
    if !@isLastPage
      @scrollToTop()
      ResultsService.nextPage()

  $ctrl.prevPage = ->
    if !@isFirstPage
      @scrollToTop()
      ResultsService.prevPage()

  $ctrl.scrollToTop = ->
    $anchorScroll('search-results-wrapper')

  $ctrl

ResultPagerController.$inject = [
  '$anchorScroll',
  'ResultsService'
]

angular
  .module('CCR')
  .component('resultsPager', {
    bindings:
      currentPage: '<'
      isFirstPage: '<'
      isLastPage: '<'
      pageSize: '<'
    templateUrl: 'results/components/results_pager.html'
    controller: ResultPagerController
  })
