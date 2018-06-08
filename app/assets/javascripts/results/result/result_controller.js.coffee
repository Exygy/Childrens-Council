ResultController = ->
  $ctrl = @

  return $ctrl

ResultController.$inject = []

angular
  .module('CCR')
  .component('result', {
    bindings:
      provider: '<'
    controller: ResultController
    templateUrl: "results/result/result.html"
  })
