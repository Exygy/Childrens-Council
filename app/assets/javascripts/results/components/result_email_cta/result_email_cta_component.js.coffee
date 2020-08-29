ResultEmailCtaController = ($scope, EmailCollectorService, HttpService) ->
  $ctrl = @

  $scope.position = {
    'position': 'absolute'
  }
  if $ctrl.searchResultCount <= 5
    $scope.position.position = 'inherit'

  validateForm = () ->
    for field_name, field_obj of $scope.emailForm
      $scope.emailForm[field_name].$setDirty() if field_name[0] != '$'

  $scope.submitEmailForm = ->
    validateForm()
    if $scope.emailForm.$valid

      # TODO: submit email to backend
      HttpService.http(
        { method: 'POST', url: '/api/store_email', data: {email: $scope.email} },
        (response) ->
          EmailCollectorService.storeEmail($scope.email)

        (error) ->
          console.log("ERROR")
          console.log(error)
      )
      
    return

  return $ctrl

ResultEmailCtaController.$inject = ['$scope', 'EmailCollectorService', 'HttpService']

angular
  .module('CCR')
  .component('resultEmailCta', {
    bindings:
      searchResultCount: '<'
    controller: ResultEmailCtaController
    templateUrl: "results/components/result_email_cta/result_email_cta.html"
  })
