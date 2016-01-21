angular.module 'CCR', [
    'templates',
    'ui.router',
  ]
  .constant '_', window._
  .config ['$locationProvider', '$stateProvider', '$urlRouterProvider', ($locationProvider, $stateProvider, $urlRouterProvider) ->
    $locationProvider.html5Mode(true)
    $stateProvider
      .state('search', {
        url: '/',
        templateUrl: 'search.html',
        controller: 'SearchController',
      })
      .state('results', {
        url: '/results',
        templateUrl: 'results.html',
        controller: 'ResultsController',
      })
    $urlRouterProvider.otherwise('/')
  ]
  .config ['$sceDelegateProvider', ($sceDelegateProvider) ->
    # white list of angular template providers
    $sceDelegateProvider.resourceUrlWhitelist [
      'self',
      'http://childrens-council.s3.amazonaws.com/**',
      'https://childrens-council.s3.amazonaws.com/**',
    ]
  ]
  .config ['$httpProvider', ($httpProvider) ->
    # HTTP Access Control https://en.wikipedia.org/wiki/Cross-origin_resource_sharing
    $httpProvider.defaults.useXDomain = true
    delete $httpProvider.defaults.headers.common['X-Requested-With']
    $httpProvider.defaults.headers.common['Accept'] = 'application/json'
    $httpProvider.defaults.headers.common['Content-Type'] = 'application/json'
  ]
