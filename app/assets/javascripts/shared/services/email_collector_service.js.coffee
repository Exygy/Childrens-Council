EmailCollectorService = ($auth, $window) ->
    $service = @
    checkAuthTimeout = null
    emailKey = 'ccEmail'
    $service.status = 
        shouldPromptEmailCta: true

    $service.checkEmailStatus = () ->
        if !checkAuthTimeout
            # there could be a delay until $auth.currentUser() returns the actual user, checking twice
            checkAuthTimeout = setTimeout () ->
                $service.checkEmailStatus()
                checkAuthTimeout = null
            , 1000

        if $auth.currentUser()
            $service.status.shouldPromptEmailCta = false
            return 
    
        email = $window.localStorage.getItem emailKey 
        $service.status.shouldPromptEmailCta = email == null

    $service.storeEmail = (email) ->
        if !email
            return    
        $window.localStorage.setItem emailKey, email
        $service.status.shouldPromptEmailCta = false

    $service

EmailCollectorService.$inject = ['$auth', '$window']
angular.module('CCR').service('EmailCollectorService', EmailCollectorService)
