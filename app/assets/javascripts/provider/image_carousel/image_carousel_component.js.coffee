ImageCarouselController = ($scope, $anchorScroll, $location) ->
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
      
  @scrollLeft = (scrollId) ->
    elem = angular.element(document.querySelector(scrollId))
    images = elem.children()
    marker = elem[0].scrollLeft
    i = 0
    if marker > 1
      while marker - images[i].offsetWidth > 0
        marker = marker - images[i].offsetWidth
        i += 1
      elem[0].scrollLeft -= marker
      
  @scrollLeftVisible = (scrollId)  ->
    elem = angular.element(document.querySelector(scrollId))
    elem[0].scrollLeft > 0

  @scrollRight = (scrollId) ->
    elem = angular.element(document.querySelector(scrollId))
    position = elem.width() + elem.scrollLeft()
    marker = elem[0].scrollWidth # full width
    i = 0
    reversedImages = _.reverse(elem.children())
    if marker > position
      while marker - reversedImages[i].offsetWidth > position
        marker = marker - reversedImages[i].offsetWidth
        i += 1
      if marker - position < 10
        marker += reversedImages[i].offsetWidth
      elem[0].scrollLeft += marker - position

  @scrollRightVisible = (scrollId) ->
    elem = angular.element(document.querySelector(scrollId))
    Math.ceil(elem[0].scrollLeft + elem.width()) < elem[0].scrollWidth

  return $ctrl

ImageCarouselController.$inject = ['$scope', '$anchorScroll', '$location']

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
