ApplicationController = ($scope, $rootScope, _, $timeout) ->
  # DOM manipulation that needs to happen after view markup is loaded
  $scope.$on '$viewContentLoaded', (event) ->
    $rootScope.state_loading = false
    $content = $(document.getElementById('content'))
    $content.siblings('.page-header').remove()
    $content.before($('.page-header'))
    $(window).on 'resize', _.debounce($scope.setSideNavWidth, 400)

  # Use timeout to wait until angular has rendered sidebar elements
  $timeout () ->
    $scope.initFoundation()
    $scope.setSideNavWidth()

  $scope.initFoundation = ->
    $(document).foundation {
      'magellan-expedition': {
        threshold: 0
        destination_threshold: 50
        offset_by_height: false
      }
    }

  $scope.setSideNavWidth = ->
    $side_nav = $('[data-magellan-expedition]')
    $side_nav.width $side_nav.parents('.columns').width() if $side_nav.length

ApplicationController.$inject = ['$scope', '$rootScope', '_', '$timeout']
angular.module('CCR').controller('ApplicationController', ApplicationController)
