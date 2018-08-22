angular.module 'CCR', [
  'angularMoment',
  'checklist-model',
  'Devise',
  'mm.foundation',
  'ngAnimate',
  'ngAria',
  'ngCookies',
  'ngMap',
  'ng-token-auth',
  'ngSanitize',
  'templates',
  'truncate',
  'ui.carousel',
  'ui.select',
  'ui.slider',
  'ui.router'
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

    $urlRouterProvider.otherwise('/')
  ]
  .config ['$httpProvider', ($httpProvider) ->
    # HTTP Access Control https://en.wikipedia.org/wiki/Cross-origin_resource_sharing
    $httpProvider.defaults.useXDomain = true
    delete $httpProvider.defaults.headers.common['X-Requested-With']
    $httpProvider.defaults.headers.common['Accept'] = 'application/json'
    $httpProvider.defaults.headers.common['Content-Type'] = 'application/json'
    $httpProvider.interceptors.push('APIInterceptor');
  ]

  .config ['$authProvider', ($authProvider) ->
    $authProvider.configure({
      apiUrl: 'http://localhost:3000/api',
      tokenValidationPath:     '/auth/validate_token',
      signOutUrl:              '/auth/sign_out',
      emailRegistrationPath:   '/auth',
      accountUpdatePath:       '/auth',
      accountDeletePath:       '/auth',
      passwordResetPath:       '/auth/password',
      passwordUpdatePath:      '/auth/password',
      emailSignInPath:         '/auth/sign_in',
      storage:                 'cookies',
      forceValidateToken:      false,
      validateOnPageLoad:      true,
      proxyIf:                 -> return false,
      proxyUrl:                '/proxy',
      omniauthWindowType:      'sameWindow',
#      authProviderPaths: {
#        github:   '/auth/github',
#        facebook: '/auth/facebook',
#        google:   '/auth/google'
#      },
      tokenFormat: {
        "access-token": "{{ token }}",
        "token-type":   "Bearer",
        "client":       "{{ clientId }}",
        "expiry":       "{{ expiry }}",
        "uid":          "{{ uid }}"
      },
      cookieOps: {
        path: "/",
        expires: 9999,
        expirationUnit: 'days',
        secure: false,
        domain: 'domain.com'
      },
      createPopup: (url) ->
        return window.open(url, '_blank', 'closebuttoncaption=Cancel')
      ,
      parseExpiry: (headers) ->
        # convert from UTC ruby (seconds) to UTC js (milliseconds)
        return (parseInt(headers['expiry']) * 1000) || null
      ,
      handleLoginResponse: (response) ->
        return response.data;
      ,
      handleAccountUpdateResponse: (response) ->
        return response.data
      ,
      handleTokenValidationResponse: (response) ->
        return response.data
    })
  ]
  .run ['$rootScope', ($rootScope) ->
    $rootScope.data = CCR_DATA
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
