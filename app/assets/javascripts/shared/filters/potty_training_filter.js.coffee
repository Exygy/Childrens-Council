PottyTrainingFilter = ($rootScope) ->
  (provider_attributes) ->
    potty_training = false
    if provider_attributes and provider_attributes.environment
      for environment in provider_attributes.environment
        if environment == "Potty Training"
          potty_training = true
    return potty_training

PottyTrainingFilter.$inject = ['$rootScope']

angular.module('CCR').filter('pottyTraining', PottyTrainingFilter)
