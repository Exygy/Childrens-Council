CheckImageDirective = ($http) ->
  {
    restrict: 'A',
    link: (scope, element, attrs) ->
      attrs.$observe('ngSrc', (ngSrc) ->
        $http.get(ngSrc).success( ->
          alert('image exist')
          element.attr('src', ngSrc)
        ).error( ->
          alert('image not exist')
          element.attr('src', attrs['ngDefault'])
        )
      )
  }

angular.module('CCR').directive('checkImage', CheckImageDirective)
