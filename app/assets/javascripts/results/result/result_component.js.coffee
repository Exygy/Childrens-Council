ResultController = ($scope, DataService) ->
  $ctrl = @

  $ctrl.$onInit = ->
    $scope.ageWeeks = DataService.parent.children[0].ageWeeks


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
