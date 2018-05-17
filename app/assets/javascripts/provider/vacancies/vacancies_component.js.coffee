VacanciesController =  ->
  return @

VacanciesController.$inject = []

angular
  .module('CCR')
  .component('vacancies', {
    bindings:
      shifts: '<'
    controller: VacanciesController
    templateUrl: "/assets/provider/vacancies/vacancies.html"
  })
