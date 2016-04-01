ToMarkers = () ->
  (providers) ->
    if providers
      for provider, index in providers
        providers[index]['isIconVisibleOnClick'] = true
        providers[index]['closeClick'] = 'none'
        providers[index]['marker_icon'] = 'icon_url_should_vary_based_on_provider_type'

        # this to prevent the digest loop to go crazy
        unless providers[index]['coords']
          providers[index]['coords'] = {
            latitude: provider.latitude,
            longitude: provider.longitude
          }

    return providers

angular.module('CCR').filter('toMarkers', ToMarkers)
