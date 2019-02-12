ResultPagerController = ($anchorScroll, ResultsService, FavoriteService) ->
  $ctrl = @

  $ctrl.nextPage = ->
    if !@isLastPage
      @scrollToTop()
      if $ctrl.service && $ctrl.service == 'favorites'
        FavoriteService.getFavorites $ctrl.currentPage + 1, $ctrl.callback
      else
        ResultsService.nextPage()


  $ctrl.prevPage = ->
    if !@isFirstPage
      @scrollToTop()
      if $ctrl.service && $ctrl.service == 'favorites'
        FavoriteService.getFavorites $ctrl.currentPage - 1, $ctrl.callback
      else
        ResultsService.prevPage()

  $ctrl.scrollToTop = ->
    $anchorScroll('search-results-wrapper')

  $ctrl

ResultPagerController.$inject = [
  '$anchorScroll',
  'ResultsService',
  'FavoriteService'
]

angular
  .module('CCR')
  .component('resultsPager', {
    bindings:
      currentPage: '<'
      isFirstPage: '<'
      isLastPage: '<'
      pageSize: '<'
      service: '<'
      callback: '<'
    templateUrl: 'results/components/results_pager/results_pager.html'
    controller: ResultPagerController
  })
