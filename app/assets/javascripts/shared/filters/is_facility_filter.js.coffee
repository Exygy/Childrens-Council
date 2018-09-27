IsFacility = ->
  (provider) ->
    if provider
      return provider.typeOfCare == "Child Care Center"
    else
      return false

IsFacility.$inject = []
angular.module('CCR').filter('isFacility', IsFacility)
