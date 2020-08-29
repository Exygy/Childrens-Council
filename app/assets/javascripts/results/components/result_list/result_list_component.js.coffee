ResultListController = ($scope, $modal, CompareService, ProviderMapService, ResultsService, EmailCollectorService) ->
  $ctrl = @
  $ctrl.providerIdsToCompare = CompareService.data.providerIds

  $scope.filters = ResultsService.filters
  $ctrl.searchSettings = ResultsService.searchSettings

  $scope.emailCollectoreStatus = EmailCollectorService.status
  EmailCollectorService.checkEmailStatus()

  $scope.$on 'auth:login-success', (event, user) ->
    EmailCollectorService.checkEmailStatus()


  $scope.$on 'search-service:updated', (event, service) ->
    $scope.filters = service.filters
    $scope.searchSettings = service.searchSettings

  $scope.$on 'results-service:updated', (event, service) ->
    $scope.filters = service.filters
    $scope.searchSettings = service.searchSettings

  $scope.openResultFiltersModal = () ->
    $modal.open {
      templateUrl: 'results/modals/result_filters_modal.html'
      controller: 'ResultFiltersModalController'
    }

  $ctrl.handleResultItemMouseenter = (provider) ->
    marker = ProviderMapService.getProviderMarker({providerId: provider.providerId})
    ProviderMapService.highlightMarker(marker, provider.typeOfCare)

  $ctrl.handleResultItemMouseleave = (provider) ->
    marker = ProviderMapService.getProviderMarker({providerId: provider.providerId})
    ProviderMapService.unHighlightMarker(marker, provider.typeOfCare)

  return $ctrl

ResultListController.$inject = ['$scope', '$modal', 'CompareService', 'ProviderMapService', 'ResultsService', 'EmailCollectorService']

angular
  .module('CCR')
  .component('resultList', {
    bindings:
      data: '<'
    controller: ResultListController
    templateUrl: "results/components/result_list/result_list.html"
  })
