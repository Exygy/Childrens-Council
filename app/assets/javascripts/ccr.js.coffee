angular.module 'CCR', [
  'angularMoment',
  'checklist-model',
  'Devise',
  'mm.foundation',
  'ngAnimate',
  'ngAria',
  'ngCookies',
  'ngMap',
  'ng-token-auth-custom',
  'ngSanitize',
  'templates',
  'truncate',
  'ui.select',
  'ui.slider',
  'ui.router',
  ]
  .constant '_', window._
  .constant 'deepFilter', window.deepFilter
  .constant 'CC_COOKIE', 'cc_api_key'
  .config ['$locationProvider', '$stateProvider', '$urlRouterProvider', ($locationProvider, $stateProvider, $urlRouterProvider) ->
    $locationProvider.html5Mode(true)
    $stateProvider
      .state('search', {
        url: '/',
        component: 'search',
        onEnter: showSidebar,
      })
      .state('results', {
        url: '/providers/',
        component: 'results',
        onEnter: hideSidebar,
      })
      .state('provider', {
        url: '/providers/:id/',
        component: 'provider',
        onEnter: hideSidebar,
        resolve: {
          id: ['$stateParams', ($stateParams) ->
            return $stateParams.id;
          ]
        }
      })
      .state('compare', {
        url: '/compare',
        component: 'compare',
        onEnter: hideSidebar,
      })
      .state('reset_password', {
        url: '/reset_password/:token/',
        component: 'search',
        onEnter: showSidebar,
        resolve: {
          token: ['$stateParams', ($stateParams) ->
            return $stateParams.token;
          ]
        }
      })
      .state('account_info', {
        url: '/account/info/',
        component: 'account',
        onEnter: hideSidebar
        resolve: {
          security: ['$q', '$auth', ($q, $auth) ->
            if(!$auth.retrieveData('auth_headers'))
              return $q.reject("Not Authorized")
          ]
        }
      })
      .state('account_favorites', {
        url: '/account/favorites/',
        component: 'favorites',
        onEnter: hideSidebar
        resolve: {
          security: ['$q', '$auth', ($q, $auth) ->
            if(!$auth.retrieveData('auth_headers'))
              return $q.reject("Not Authorized")
          ]
        }
      })

    $urlRouterProvider.otherwise('/')
  ]
  .config ['$httpProvider', ($httpProvider) ->
    # HTTP Access Control https://en.wikipedia.org/wiki/Cross-origin_resource_sharing
    $httpProvider.defaults.useXDomain = true
    delete $httpProvider.defaults.headers.common['X-Requested-With']
    $httpProvider.defaults.headers.common['Accept'] = 'application/json'
    $httpProvider.defaults.headers.common['Content-Type'] = 'application/json'
    $httpProvider.interceptors.push('APIInterceptor')
  ]

  .config ['$authProvider', ($authProvider) ->
    $authProvider.configure({
      apiUrl: CCR_ENV['RAILS_API_URL'] + '/api'
    })
  ]
  .run ['$rootScope', '$state', '$transitions', ($rootScope, $state, $transitions) ->
    $transitions.onError {}, ($transition$)  ->
      if $transition$._error.type != 5
        $state.go("search")
    $rootScope.state_loading = false
    $rootScope.$on '$stateChangeStart', (event) ->
      $rootScope.state_loading = true
      # state_loading set to false when $viewContentLoaded is triggered within each state controller
  ]

hideSidebar = () ->
  $(document.getElementById('main')).addClass 'expanded'
  $(document.getElementById('sidebar')).addClass 'hide'
  $(document.getElementById('content')).addClass 'providers'

showSidebar = () ->
  $(document.getElementById('main')).removeClass 'expanded'
  $(document.getElementById('sidebar')).removeClass 'hide'
  $(document.getElementById('content')).removeClass 'providers'
  if !document.getElementById('need-help')
    $(document.getElementById('sidebar')).append("<div id='need-help' class='panel ccr-scope margin-top-2'>" +
      "<h6>Need More Help?</h6>" +
      "<p><a href='mailto:rr@childrenscouncil.org'>Write an email</a><br/>" +
      "<a href='tel:415-343-3300'>Call 415-343-3300</a></p>" +
      "<p class='small margin-top-1'>Counselors available<br/>Mon–Thu 8:30am– 4pm<br/>Fri 8:30am–noon</p></div>")
