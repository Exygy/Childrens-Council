ValidateFirstNameLastName = ->
  {
    require: 'ngModel'
    link: (scope, element, attr, mCtrl) ->
      validateFirstNameLastName = (value) ->
        if value.indexOf(' ') > -1
          mCtrl.$setValidity 'charE', true
        else
          mCtrl.$setValidity 'charE', false
        value
      mCtrl.$parsers.push validateFirstNameLastName
      return
  }
angular.module('CCR').directive('validateFirstNameLastName', ValidateFirstNameLastName)
