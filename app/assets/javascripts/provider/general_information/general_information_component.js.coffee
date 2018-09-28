GeneralInformationController =  ->
  return @

GeneralInformationController.$inject = []

angular
  .module('CCR')
  .component('generalInformation', {
    bindings:
      provider: '<'
    controller: GeneralInformationController
    templateUrl: "provider/general_information/general_information.html"
  })
