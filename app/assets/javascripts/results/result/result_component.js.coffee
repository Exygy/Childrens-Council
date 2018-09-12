ResultController = ($scope, DataService) ->
  $ctrl = @

  $ctrl.providerName = (provider) ->
    name = provider.centerName
    if !name
      if provider.primaryOwner
        name = "#{provider.primaryOwner.firstName} #{provider.primaryOwner.lastName}"
      else
        name = "Name Unknown"
    name

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
