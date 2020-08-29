EmailCollectorService = ($auth, $window) ->
    emailKey = 'ccEmail'
    @status = 
        shouldPromptEmailCta: true

    @checkEmailStatus = () ->
        email = $window.localStorage.getItem emailKey 
        @status.shouldPromptEmailCta = email == null

    @storeEmail = (email) ->
        if !email
            return    
        $window.localStorage.setItem emailKey, email
        @status.shouldPromptEmailCta = false

    @


EmailCollectorService.$inject = ['$auth', '$window']
angular.module('CCR').service('EmailCollectorService', EmailCollectorService)
