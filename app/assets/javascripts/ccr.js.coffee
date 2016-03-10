angular.module 'CCR', [
    'templates',
    'ui.router',
    'uiGmapgoogle-maps',
    'ngCookies',
    'mm.foundation',
    'checklist-model',
    'ui.select',
  ]
  .constant '_', window._
  .constant 'deepFilter', window.deepFilter
  .constant 'CC_COOKIE', 'cc_api_key'
  .config ['$locationProvider', '$stateProvider', '$urlRouterProvider', ($locationProvider, $stateProvider, $urlRouterProvider) ->
    $locationProvider.html5Mode(true)
    $stateProvider
      .state('search', {
        url: '/',
        templateUrl: 'search/search.html',
        controller: 'SearchController',
        onEnter: showSidebar,
      })
      .state('results', {
        url: '/providers',
        templateUrl: 'results/results.html',
        controller: 'ResultsController',
        onEnter: hideSidebar,
      })
      .state('provider', {
        url: '/providers/:id',
        templateUrl: 'provider/provider.html',
        controller: 'ProviderController',
        onEnter: hideSidebar,
        resolve:
          provider: ['$stateParams', 'ProviderService', ($stateParams, ProviderService) ->
            ProviderService.getProvider($stateParams.id)
          ]
      })
    $urlRouterProvider.otherwise('/')
  ]
  .config [ 'uiGmapGoogleMapApiProvider', (uiGmapGoogleMapApiProvider) ->
    uiGmapGoogleMapApiProvider.configure(
        key: 'AIzaSyCI85KTN1V7hI-oGLijsoGFuJUWbWRjW1A',
        v: '3.20', #defaults to latest 3.X anyhow
        libraries: 'weather,geometry,visualization'
    )
  ]
  .config ['$httpProvider', ($httpProvider) ->
    # HTTP Access Control https://en.wikipedia.org/wiki/Cross-origin_resource_sharing
    $httpProvider.defaults.useXDomain = true
    delete $httpProvider.defaults.headers.common['X-Requested-With']
    $httpProvider.defaults.headers.common['Accept'] = 'application/json'
    $httpProvider.defaults.headers.common['Content-Type'] = 'application/json'
    $httpProvider.interceptors.push('APIInterceptor');
  ]

hideSidebar = () ->
  $(document.getElementById('main')).addClass 'expanded'
  $(document.getElementById('sidebar')).addClass 'hide'

showSidebar = () ->
  $(document.getElementById('main')).removeClass 'expanded'
  $(document.getElementById('sidebar')).removeClass 'hide'
