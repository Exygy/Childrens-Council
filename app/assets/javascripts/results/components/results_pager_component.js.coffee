angular.module('CCR')
.component 'resultsPager', {
  bindings:
    currentPage: '<'
    isFirstPage: '<'
    isLastPage: '<'
    pageSize: '<'
  templateUrl: 'results/components/results_pager.html'
  controller: ['ResultsService', '$anchorScroll', (ResultsService, $anchorScroll) ->
    @nextPage = ->
      if !@isLastPage
        @scrollToTop()
        ResultsService.nextPage()

    @prevPage = ->
      if !@isFirstPage
        @scrollToTop()
        ResultsService.prevPage()

    @scrollToTop = ->
      $anchorScroll('search-results-wrapper')

    @
  ]
}
