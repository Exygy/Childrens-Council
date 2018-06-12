BadgesController = ($scope, BadgesService) ->
  $ctrl = @
  $scope.badges = []

  @$onInit = () ->
    for badges in [$ctrl.attributes.local12, $ctrl.attributes.accreditations]
      if badges
        for badge in badges
          if BadgesService.allowed(badge)
            $scope.badges.push(badge)

  return @

BadgesController.$inject = ['$scope', 'BadgesService']

angular
  .module('CCR')
  .component('badges', {
    bindings:
      attributes: '<',
      showTitle: '<'
    controller: BadgesController
    templateUrl: "badges/badges.html"
  })
