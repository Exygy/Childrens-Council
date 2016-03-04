NeighborhoodIdToName = ->
  (neighborhood_id) ->
    CCR_DATA['neighborhoods'][neighborhood_id].text

angular.module('CCR').filter('neighborhoodIdToName', NeighborhoodIdToName)

StateIdToName = ->
  (state_id) ->
    CCR_DATA['states'][state_id].name

angular.module('CCR').filter('stateIdToName', StateIdToName)

StateIdToAbbr = ->
  (state_id) ->
    CCR_DATA['states'][state_id].abbr

angular.module('CCR').filter('stateIdToAbbr', StateIdToAbbr)

CityIdToName = ->
  (city_id) ->
    CCR_DATA['cities'][city_id].text

angular.module('CCR').filter('cityIdToName', CityIdToName)
