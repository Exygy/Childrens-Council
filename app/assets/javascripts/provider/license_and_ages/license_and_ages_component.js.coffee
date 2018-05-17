LicenseAndAgesController =  ->
  return @

LicenseAndAgesController.$inject = []

angular
  .module('CCR')
  .component('licenseAndAges', {
    bindings:
      id: '<',
      capacity: '<'
    controller: LicenseAndAgesController
    templateUrl: "/assets/provider/license_and_ages/license_and_ages.html"
  })
