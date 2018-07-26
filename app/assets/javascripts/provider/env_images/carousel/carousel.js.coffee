CarouselController = ($scope, urls)  ->
  $scope.urls = urls

  $scope.tttt = [1,2,3,4]

  return @

CarouselController.$inject = ['$scope', 'urls']

angular
  .module('CCR')
  .controller('CarouselController', CarouselController)
