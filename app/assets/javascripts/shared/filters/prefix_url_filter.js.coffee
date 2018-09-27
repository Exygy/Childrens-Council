PrefixUrlFilter = () ->
  (value) ->
    return value if !value
    return value if 'http://'.indexOf(value) == 0 or 'https://'.indexOf(value) == 0
    return value if value.indexOf('http://') == 0 or value.indexOf('https://') == 0
    return 'http://' + value

angular.module('CCR').filter('prefixUrl', PrefixUrlFilter)
