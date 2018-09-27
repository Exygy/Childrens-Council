ToSocialNetworkNameFilter = ->
  (social_media_url) ->
    capitalize = (string) ->
      string.charAt(0).toUpperCase() + string.slice(1)

    social_networks = ['facebook', 'twitter', 'yelp', 'instagram', 'youtube']
    for social_network in social_networks
      if social_media_url.indexOf(social_network) > -1
        return capitalize(social_network);
        
    return social_media_url

ToSocialNetworkNameFilter.$inject = []
angular.module('CCR').filter('toSocialNetworkName', ToSocialNetworkNameFilter)
