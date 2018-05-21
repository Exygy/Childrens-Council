VacanciesController =  ->
  return @

VacanciesController.$inject = []

angular
  .module('CCR')
  .component('vacancies', {
    bindings:
      shifts: '<'
    controller: VacanciesController
    templateUrl: "provider/vacancies/vacancies.html"
  })
