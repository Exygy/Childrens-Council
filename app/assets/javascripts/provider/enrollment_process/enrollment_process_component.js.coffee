EnrollmentProcessController =  ->
  return @

EnrollmentProcessController.$inject = []

angular
  .module('CCR')
  .component('enrollmentProcess', {
    bindings:
      provider: '<'
    controller: EnrollmentProcessController
    templateUrl: "provider/enrollment_process/enrollment_process.html"
  })
