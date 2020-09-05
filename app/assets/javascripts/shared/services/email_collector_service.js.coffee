EmailCollectorService = ($auth, $window) ->
    $service = @
    checkAuthTimeout = null
    emailKey = 'ccEmail'
    $service.status = 
        shouldPromptEmailCta: true
        limit: 5

    $service.checkEmailStatus = () ->
        if !checkAuthTimeout
            # there could be a delay until $auth.currentUser() returns the actual user, checking twice
            checkAuthTimeout = setTimeout () ->
                $service.checkEmailStatus()
                checkAuthTimeout = null
            , 1000

        if $auth.currentUser()
            $service.status.shouldPromptEmailCta = false
            $service.status.limit = 15
            return 
    
        email = $window.localStorage.getItem emailKey 
        if email == null
            $service.status.shouldPromptEmailCta = true
            $service.status.limit = 5
        else
            $service.status.shouldPromptEmailCta = false
            $service.status.limit = 15

    $service.storeEmail = (email) ->
        if !email
            return    
        $window.localStorage.setItem emailKey, email
        $service.status.shouldPromptEmailCta = false
        $service.status.limit = 15

    $service

EmailCollectorService.$inject = ['$auth', '$window']
angular.module('CCR').service('EmailCollectorService', EmailCollectorService)
