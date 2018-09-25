ResultController = ($scope, DataService) ->
  $ctrl = @

  $ctrl.$onInit = ->
    $scope.show_map = false
    $scope.ageWeeks = DataService.parent.children[0].ageWeeks

  $scope.toogleMap = ->
    $scope.show_map = !$scope.show_map

  return $ctrl

ResultController.$inject = ['$scope', 'DataService']

angular
  .module('CCR')
  .component('result', {
    bindings:
      provider: '<'
    controller: ResultController
    templateUrl: "results/result/result.html"
  })
