LicenseAndAgesController = ($scope) ->
  $ctrl = @

  licenseToAgeGroupTypeId = (license_key) ->
    field_mapping =
      'config5': 102,
      'config7': 106,
      'config9': 108,
      'config11': 109
    return field_mapping[license_key]

  $scope.enrollmentField = (license_key, field) ->
    age_group_type_id = licenseToAgeGroupTypeId(license_key)
    return age_group_type_id if field == 'ageGroupTypeId'
    for enrollment in $ctrl.enrollments
      if enrollment.ageGroupTypeId == age_group_type_id
        return enrollment[field]

  return @

LicenseAndAgesController.$inject = ['$scope']

angular
  .module('CCR')
  .component('licenseAndAges', {
    bindings:
      enrollments: '<',
      generalInfo: '<'
    controller: LicenseAndAgesController
    templateUrl: "provider/license_and_ages/license_and_ages.html"
  })
