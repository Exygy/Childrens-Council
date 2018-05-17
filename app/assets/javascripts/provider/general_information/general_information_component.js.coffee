GeneralInformationController =  ->
  return @

GeneralInformationController.$inject = []

angular
  .module('CCR')
  .component('generalInformation', {
    bindings:
      provider: '<'
    controller: GeneralInformationController
    templateUrl: "/assets/provider/general_information/general_information.html"
  })
