QrisRatingController = ($scope)  ->

  return @

QrisRatingController.$inject = ['$scope']

angular
  .module('CCR')
  .component('qrisRating', {
    bindings:
      qris: '<'
    controller: QrisRatingController
    templateUrl: "provider/qris_rating/qris_rating.html"
  })
