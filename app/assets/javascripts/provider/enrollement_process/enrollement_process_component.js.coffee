EnrollementProcessController =  ->
  return @

EnrollementProcessController.$inject = []

angular
  .module('CCR')
  .component('enrollementProcess', {
    bindings:
      urls: '<'
    controller: EnrollementProcessController
    templateUrl: "/assets/provider/enrollement_process/enrollement_process.html"
  })
