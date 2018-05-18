EnrollmentProcessController =  ->
  return @

EnrollmentProcessController.$inject = []

angular
  .module('CCR')
  .component('enrollmentProcess', {
    bindings:
      urls: '<'
    controller: EnrollmentProcessController
    templateUrl: "/assets/provider/enrollment_process/enrollment_process.html"
  })
