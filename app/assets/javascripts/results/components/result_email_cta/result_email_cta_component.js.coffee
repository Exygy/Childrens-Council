ResultEmailCtaController = ($scope, EmailCollectorService) ->
  $ctrl = @

  validateForm = () ->
    for field_name, field_obj of $scope.emailForm
      $scope.emailForm[field_name].$setDirty() if field_name[0] != '$'

  $scope.submitEmailForm = ->
    validateForm()
    if $scope.emailForm.$valid

      # TODO: submit email to backend



      EmailCollectorService.storeEmail($scope.email)
    return

  return $ctrl

ResultEmailCtaController.$inject = ['$scope', 'EmailCollectorService']

angular
  .module('CCR')
  .component('resultEmailCta', {
    bindings:
      data: '<'
    controller: ResultEmailCtaController
    templateUrl: "results/components/result_email_cta/result_email_cta.html"
  })
