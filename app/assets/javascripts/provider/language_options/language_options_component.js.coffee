LanguageOptionsController =  ->
  return @

LanguageOptionsController.$inject = []

angular
  .module('CCR')
  .component('languageOptions', {
    bindings:
      urls: '<'
    controller: LanguageOptionsController
    templateUrl: "/assets/provider/language_options/language_options.html"
  })
