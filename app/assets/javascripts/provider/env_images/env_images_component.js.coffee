EnvImagesController = ($scope, $modal)  ->
  $ctrl = @

  $scope.openCarousel = () ->
    $modal.open {
      templateUrl: '/assets/provider/env_images/carousel/carousel.html'
      controller: 'CarouselController'
      resolve:
        urls: ->
           $ctrl.urls
    }

  return @

EnvImagesController.$inject = ['$scope', '$modal']

angular
  .module('CCR')
  .component('envImages', {
    bindings:
      urls: '<'
    controller: EnvImagesController
    templateUrl: "provider/env_images/env_images.html"
  })
