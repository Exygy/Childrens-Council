HoursController = ($scope)  ->
  $ctrl = @
  $scope.days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']

  return @

HoursController.$inject = ['$scope']

angular
  .module('CCR')
  .component('hours', {
    bindings:
      shiftDays: '<'
    controller: HoursController
    templateUrl: "provider/hours/hours.html"
  })
