VacanciesController = ($scope)  ->
  $ctrl = @

  $scope.isFutureVacancy = (vacancy_date) ->
    Date.parse(vacancy_date) > Date.now()

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
    templateUrl: "provider/vacancies/vacancies.html"
  })
