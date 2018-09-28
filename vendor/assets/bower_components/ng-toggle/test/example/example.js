(function(){

  var module = angular.module('example', [
    'toggles'
  ]);

  module.controller('ExampleCtrl', [
    '$scope',
    function($scope){
      $scope.buttons = [
        { name: 'Open', content: 'This is where you open a thing.' },
        { name: 'Move', content: 'This is where you move another thing.' },
        { name: 'Print', content: 'This is where you try to print something and realize you are out of ink.' }
      ];

      $scope.options = [
        { name: 'Preview', content: 'Here is the preview.' },
        { name: 'Edit', content: 'Here is the fancy editor.' }
      ];
    }
  ]);
})();
