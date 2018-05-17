EnvImagesController =  ->
  return @

EnvImagesController.$inject = []

angular
  .module('CCR')
  .component('envImages', {
    bindings:
      urls: '<'
    controller: EnvImagesController
    templateUrl: "/assets/provider/env_images/env_images.html"
  })
