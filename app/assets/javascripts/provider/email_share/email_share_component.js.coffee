angular
  .module('CCR')
  .component('emailShare', {
    bindings:
      provider: '<'
    templateUrl: 'provider/email_share/email_share.html'
    controller: ->
      $ctrl = @
      $ctrl.emailSubject = 'Check%20out%20this%20child%20care%20program!'
      $ctrl.emailBody =
        "Someone has used the Children’s Council Child Care Finder to send you a recommendation:
        https://www.childrenscouncil.org/families/find-child-care/child-care-referrals/child-care-search/providers/#{$ctrl.provider.providerId}/."
  })
