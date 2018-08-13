ResultController = ($scope, DataService) ->
  $ctrl = @

  $ctrl.$onInit = ->
    $scope.age_weeks = DataService.parent.children[0].age_weeks


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
