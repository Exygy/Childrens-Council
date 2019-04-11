angular
  .module('CCR')
  .component('rates', {
    bindings:
      rates: '<'
    templateUrl: "provider/rates/rates.html"
    controller: ['$timeout', '$anchorScroll', '$location', ($timeout, $anchorScroll, $location) ->
      $timeout(
        () ->
          $anchorScroll() if $location.hash() == 'provider-rates'
      )
    ]
  })
