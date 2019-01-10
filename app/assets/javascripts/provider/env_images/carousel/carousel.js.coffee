CarouselController = ($scope, urls, selected, header)  ->
  $scope.urls = urls
  $scope.selected = selected
  $scope.header = header

  return @

CarouselController.$inject = ['$scope', 'urls', 'selected', 'header']

angular
  .module('CCR')
  .controller('CarouselController', CarouselController)
