ToMarkers = () ->
  (providers) ->
    if providers
      for provider, index in providers
        providers[index]['title'] = provider.name
        providers[index]['isIconVisibleOnClick'] = true
        providers[index]['closeClick'] = 'none'

        # this to prevent the digest loop to go crazy
        unless providers[index]['coords']
          providers[index]['coords'] = {
            latitude: provider.latitude,
            longitude: provider.longitude
          }
        
    return providers

angular.module('CCR').filter('toMarkers', ToMarkers)
