VacanciesController = ($scope)  ->
  $ctrl = @

  $scope.futureVacancy = (key) ->
    field_mapping =
      102: 'config6',
      104: 'MISSING',
      106: 'config8',
      108: 'config10',
      109: 'config12'
    return $ctrl.generalInfo[field_mapping[key]]


  return @

VacanciesController.$inject = ['$scope']

angular
  .module('CCR')
  .component('vacancies', {
    bindings:
      generalInfo: '<',
      enrollments: '<'
    controller: VacanciesController
    templateUrl: "vacancies/vacancies.html"
  })
