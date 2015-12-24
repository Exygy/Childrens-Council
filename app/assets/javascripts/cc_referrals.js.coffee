angular.module 'CCReferrals', [
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
