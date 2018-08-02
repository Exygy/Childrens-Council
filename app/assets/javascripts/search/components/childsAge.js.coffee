angular.module('CCR')
.component 'childsAge', {
  bindings:
    model: '<'
  templateUrl: 'search/components/childs-age.html'
  controller: ['SearchService', '$state', '$scope', (SearchService, $state, $scope) ->

  ]
}
