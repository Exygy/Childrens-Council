AttributeFilter = () ->
  (attribute) ->
    _.kebabCase(attribute)

angular.module('CCR').filter('attribute', AttributeFilter)
