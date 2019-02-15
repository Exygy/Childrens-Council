angular
  .module('CCR')
  .component('compareProvidersRatio', {
    bindings:
      child: '<'
      enrollments: '<'
    templateUrl: "compare/compare_providers_ratio/compare_providers_ratio.html"
    controller: ['AgeToAgeGroupService', (AgeToAgeGroupService) ->
      $ctrl = @

      $ctrl.$onInit = ->
        ageGroups = AgeToAgeGroupService.ageToAgeGroup($ctrl.child.ageWeeks)
        $ctrl.enrollmentsForAge = $ctrl.enrollments.filter (e) ->
          ageGroups.indexOf(e.ageGroup) > -1

      $ctrl
    ]
  })
