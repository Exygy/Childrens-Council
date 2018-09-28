FormatProviderName = (provider, rootScope, name) ->
  if name
    return "#{name}"
  else
    return "#{provider.primaryOwner.firstName} #{provider.primaryOwner.lastName}"







ProviderName = ($rootScope) ->
  (provider) ->
    if provider?
      FormatProviderName(provider, $rootScope, provider.centerName)
    else
      ''

ProviderName.$inject = ['$rootScope']

angular.module('CCR').filter('providerName', ProviderName)






ProviderContactName = ($rootScope) ->
  (provider) ->
    if provider?
      FormatProviderName(provider, $rootScope, provider.contact_name)
    else
      ''

ProviderContactName.$inject = ['$rootScope']

angular.module('CCR').filter('providerContactName', ProviderContactName)
