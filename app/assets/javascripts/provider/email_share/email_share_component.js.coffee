angular
  .module('CCR')
  .component('emailShare', {
    bindings:
      provider: '<'
    templateUrl: 'provider/email_share/email_share.html'
    controller: ->
      $ctrl = @
      $ctrl.emailSubject = 'Check%20out%20this%20Child%20Care%20Program!'
      $ctrl.emailBody =
        "Here is a Child Care Program that has been recommended for you:
        https://www.childrenscouncil.org/families/find-child-care/child-care-referrals/child-care-search/providers/#{$ctrl.provider.providerId}/.
        Check out full profiles on the Child Care Finder at
        https://www.childrenscouncil.org/childcarefinder/."
  })
