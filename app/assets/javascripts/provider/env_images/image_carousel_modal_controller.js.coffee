CarouselController = ($scope, urls, selected, header, $modalInstance)  ->
  $ctrl = @
  $scope.urls = urls
  $scope.selected = selected
  $scope.header = header

  $scope.close = ->
    $modalInstance.close()

  return @

CarouselController.$inject = ['$scope', 'urls', 'selected', 'header', '$modalInstance']

angular
  .module('CCR')
  .controller('CarouselController', CarouselController)
