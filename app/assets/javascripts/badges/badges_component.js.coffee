BadgesController = ($scope, BadgesService) ->
  $ctrl = @
  $scope.badges = []

  $ctrl.attributeNames = ->
    ['local2', 'local12', 'accreditations', 'training']

  $ctrl.getAttributes = (attribute_name) ->
    $ctrl.provider.attributes[attribute_name] || $ctrl.provider.generalInfo[attribute_name]

  @$onInit = ->
    for attribute_name in $ctrl.attributeNames()
      attributes = $ctrl.getAttributes(attribute_name)
      if attributes
        for badge in attributes
          if BadgesService.allowed(badge)
            $scope.badges.push(badge)

  return @

BadgesController.$inject = ['$scope', 'BadgesService']

angular
  .module('CCR')
  .component('badges', {
    bindings:
      attributes: '<'
      showTitle: '<'
      showInfoItemOnly: '<'
    controller: BadgesController
    templateUrl: "badges/badges.html"
  })
