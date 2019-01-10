ImageCarouselController = ($scope) ->
  $ctrl = @

  @onImageClick = (image) ->
    if $ctrl.imageClick
      $ctrl.imageClick(image)
    else
      $ctrl.selected = image

  @isActive = (image) ->
    if image == $ctrl.selected
      true
    else
      false

  @isFirst = ->
    $ctrl.selected == $ctrl.images[0]

  @isLast = ->
    $ctrl.selected == $ctrl.images[$ctrl.images.length - 1]

  @next = ->
    index = _.indexOf($ctrl.images, $ctrl.selected)
    if index + 1 < $ctrl.images.length
      $ctrl.selected = $ctrl.images[index + 1]

  @previous = ->
    index = _.indexOf($ctrl.images, $ctrl.selected)
    if index - 1 >= 0
      $ctrl.selected = $ctrl.images[index - 1]

  return $ctrl

ImageCarouselController.$inject = ['$scope']

angular
  .module('CCR')
  .component('imageCarousel', {
    bindings: {
      images: '<'
      header: '<'
      imageClick: '<'
      selected: '<'
    }
    controller: ImageCarouselController
    templateUrl: "provider/image_carousel/image_carousel.html"
  })
