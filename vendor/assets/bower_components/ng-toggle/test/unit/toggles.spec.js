(function () {
  'use strict';

  var $doc;

  var setup = function(){
    var doc = document.implementation.createHTMLDocument();
    $doc = angular.element(doc.body);
    $doc[0].documentElement = $doc[0];

    module('toggles', function($provide){
      $provide.value('$document', $doc);
    });

    inject(function($animate){
      // Override animate so it happens immediately for easier testing.
      $animate.enter = function(clone, __, element){
        element.append(clone);
      };
    });
  };

  var q = function(el, sel){
    return angular.element(el[0].querySelector(sel));
  };

  var click = function(el, sel){
    var toClick = q(el, sel);
    expect(toClick.length).toBe(1);
    toClick.triggerHandler('click');
  };

  var text = function(el, sel){
    var toText = q(el, sel);
    expect(toText.length).toBe(1);
    return toText.text();
  };

  var works = function(el, content){
    expect(q(el, '[ng-toggled]').text()).toBe('');

    click(el, '[ng-toggle]');
    expect(text(el, '[ng-toggled]')).toBe(content);

    click(el, '[ng-toggle]');
    expect(text(el, '[ng-toggled]')).toBe('');
  };

  describe('toggle tests', function () {
    beforeEach(setup);

    it('works for simple toggles', inject(function($compile, $rootScope) {
      var el = angular.element('<div><div ng-toggle="foo">Foo</div><div ng-toggled="foo">Foo content.</div></div>');
      var scope = $rootScope.$new();
      el = $compile(el)(scope);
      scope.$apply();
      works(el, 'Foo content.');
    }));

    it('supports interpolation in toggle names', inject(function ($compile, $rootScope) {
      var el = angular.element('<div><div ng-toggle="foo-{{ name }}">Foo</div><div ng-toggled="foo-hello">Foo content.</div></div>');
      var scope = $rootScope.$new();
      scope.name = 'hello';
      el = $compile(el)(scope);
      scope.$apply();
      works(el, 'Foo content.');
    }));

    it('supports interpolation in toggled names', inject(function ($compile, $rootScope) {
      var el = angular.element('<div><div ng-toggle="foo-hello">Foo</div><div ng-toggled="foo-{{ name }}">Foo content.</div></div>');
      var scope = $rootScope.$new();
      scope.name = 'hello';
      el = $compile(el)(scope);
      scope.$apply();
      works(el, 'Foo content.');
    }));

    it('supports multiple toggles', inject(function($compile, $rootScope) {
      var el = angular.element('<div>' +
        '<div ng-toggle="foo" id="one">Foo 1</div><div ng-toggle="foo" id="two">Foo 2</div>' +
        '<div ng-toggled="foo">Foo content.</div>' +
        '</div>'
      );
      var scope = $rootScope.$new();
      el = $compile(el)(scope);
      scope.$apply();

      var content = 'Foo content.';

      expect(q(el, '[ng-toggled]').text()).toBe('');

      click(el, '#one');
      expect(text(el, '[ng-toggled]')).toBe(content);

      click(el, '#one');
      expect(text(el, '[ng-toggled]')).toBe('');

      click(el, '#two');
      expect(text(el, '[ng-toggled]')).toBe(content);

      click(el, '#two');
      expect(text(el, '[ng-toggled]')).toBe('');
    }));

    it('supports multiple toggleds', inject(function($compile, $rootScope) {
      var el = angular.element('<div>' +
        '<div ng-toggle="foo">Foo</div>' +
        '<div ng-toggled="foo" id="one">Foo content 1.</div>' +
        '<div ng-toggled="foo" id="two">Foo content 2.</div>' +
        '</div>'
      );
      var scope = $rootScope.$new();
      el = $compile(el)(scope);
      scope.$apply();

      expect(q(el, '#one').text()).toBe('');
      expect(q(el, '#two').text()).toBe('');

      click(el, '[ng-toggle]');
      expect(q(el, '#one').text()).toBe('Foo content 1.');
      expect(q(el, '#two').text()).toBe('Foo content 2.');

      click(el, '[ng-toggle]');
      expect(q(el, '#one').text()).toBe('');
      expect(q(el, '#two').text()).toBe('');
    }));

    it('supports nested toggles', inject(function($compile, $rootScope) {
      var el = angular.element('<div>' +
        '<div ng-toggle="foo">Foo</div>' +
        '<div ng-toggled="foo">Foo content. <div ng-toggle="bar">Bar.</div><div ng-toggled="bar">Bar content.</div></div>' +
        '</div>'
      );
      var scope = $rootScope.$new();
      el = $compile(el)(scope);
      scope.$apply();

      expect(text(el, '[ng-toggled="foo"]')).toBe('');
      click(el, '[ng-toggle="foo"]');
      expect(text(el, '[ng-toggled="foo"]')).toBe('Foo content. Bar.');
      expect(text(el, '[ng-toggled="bar"]')).toBe('');

      click(el, '[ng-toggle="bar"]');
      expect(text(el, '[ng-toggled="foo"]')).toBe('Foo content. Bar.Bar content.');
      expect(text(el, '[ng-toggled="bar"]')).toBe('Bar content.');

      click(el, '[ng-toggle="bar"]');
      expect(text(el, '[ng-toggled="foo"]')).toBe('Foo content. Bar.');
      expect(text(el, '[ng-toggled="bar"]')).toBe('');

      click(el, '[ng-toggle="foo"]');
      expect(text(el, '[ng-toggled="foo"]')).toBe('');
    }));
  });

  describe('default tests', function(){
    beforeEach(setup);

    it('supports fixed default state', inject(function ($compile, $rootScope) {
      var el = angular.element('<div><div ng-toggle="foo" ng-toggle-default>Foo</div><div ng-toggled="foo">Foo content.</div></div>');
      var scope = $rootScope.$new();
      el = $compile(el)(scope);
      scope.$apply();

      // Already open.
      expect(text(el, '[ng-toggled]')).toBe('Foo content.');

      // Close.
      click(el, '[ng-toggle]');
      expect(text(el, '[ng-toggled]')).toBe('');

      // Still works.
      works(el, 'Foo content.');
    }));

    it('supports evaluated default state (open)', inject(function ($compile, $rootScope) {
      var el = angular.element('<div><div ng-toggle="foo" ng-toggle-default="d">Foo</div><div ng-toggled="foo">Foo content.</div></div>');
      var scope = $rootScope.$new();
      scope.d = true;
      el = $compile(el)(scope);
      scope.$apply();

      // Already open.
      expect(text(el, '[ng-toggled]')).toBe('Foo content.');

      // Close.
      click(el, '[ng-toggle]');

      // Still works.
      works(el, 'Foo content.');
    }));

    it('supports evaluated default state (closed)', inject(function ($compile, $rootScope) {
      var el = angular.element('<div><div ng-toggle="foo" ng-toggle-default="d">Foo</div><div ng-toggled="foo">Foo content.</div></div>');
      var scope = $rootScope.$new();
      scope.d = false;
      el = $compile(el)(scope);
      scope.$apply();

      works(el, 'Foo content.')
    }));
  });

  describe('group tests', function(){
    beforeEach(setup);

    it('should close other toggles in a group when one is opened', inject(function ($compile, $rootScope) {
      var el = angular.element(
        '<div>' +
          '<div ng-toggle="foo" ng-toggle-group="group">Foo</div><div ng-toggled="foo">Foo content.</div>' +
          '<div ng-toggle="bar" ng-toggle-group="group">Bar</div><div ng-toggled="bar">Bar content.</div>' +
        '</div>'
      );
      var scope = $rootScope.$new();
      el = $compile(el)(scope);
      scope.$apply();

      expect(text(el, '[ng-toggled="foo"]')).toBe('');
      expect(text(el, '[ng-toggled="bar"]')).toBe('');

      click(el, '[ng-toggle="foo"]');
      expect(text(el, '[ng-toggled="foo"]')).toBe('Foo content.');
      expect(text(el, '[ng-toggled="bar"]')).toBe('');

      click(el, '[ng-toggle="bar"]');
      expect(text(el, '[ng-toggled="foo"]')).toBe('');
      expect(text(el, '[ng-toggled="bar"]')).toBe('Bar content.');

      click(el, '[ng-toggle="bar"]');
      expect(text(el, '[ng-toggled="foo"]')).toBe('');
      expect(text(el, '[ng-toggled="bar"]')).toBe('');
    }));

    it('should not close when uncloseable', inject(function ($compile, $rootScope) {
      var el = angular.element(
        '<div>' +
          '<div ng-toggle="foo" ng-toggle-group="group" ng-toggle-closeable="false">Foo</div><div ng-toggled="foo">Foo content.</div>' +
          '<div ng-toggle="bar" ng-toggle-group="group" ng-toggle-closeable="false">Bar</div><div ng-toggled="bar">Bar content.</div>' +
        '</div>'
      );
      var scope = $rootScope.$new();
      el = $compile(el)(scope);
      scope.$apply();

      expect(text(el, '[ng-toggled="foo"]')).toBe('Foo content.');
      expect(text(el, '[ng-toggled="bar"]')).toBe('');

      click(el, '[ng-toggle="foo"]');
      expect(text(el, '[ng-toggled="foo"]')).toBe('Foo content.');
      expect(text(el, '[ng-toggled="bar"]')).toBe('');

      click(el, '[ng-toggle="bar"]');
      expect(text(el, '[ng-toggled="foo"]')).toBe('');
      expect(text(el, '[ng-toggled="bar"]')).toBe('Bar content.');

      click(el, '[ng-toggle="bar"]');
      expect(text(el, '[ng-toggled="foo"]')).toBe('');
      expect(text(el, '[ng-toggled="bar"]')).toBe('Bar content.');
    }));
  });

  describe('auto-close tests', function () {
    beforeEach(setup);

    it('click off test', inject(function ($compile, $document, $rootScope, toggles) {
      var el = angular.element('<div><span">Another thing</span><div ng-toggle="foo" ng-toggle-auto-close>Foo</div><div ng-toggled="foo">Foo content.</div></div>');
      var scope = $rootScope.$new();
      el = $compile(el)(scope);

      scope.$apply();

      // Open the toggle, verify it is open.
      click(el, '[ng-toggle]');
      expect(text(el, '[ng-toggled]')).toBe('Foo content.');

      // Click something else, verify the toggle closes.
      $document.triggerHandler('click');
      expect(text(el, '[ng-toggled]')).toBe('');
    }));

    it('click on test', inject(function ($compile, $rootScope) {
      var el = angular.element('<div><span>Another thing</span><div ng-toggle="foo" ng-toggle-auto-close>Foo</div><div ng-toggled="foo">Foo content.</div></div>');
      var scope = $rootScope.$new();
      el = $compile(el)(scope);
      scope.$apply();

      // Open the toggle, verify it is open.
      click(el, '[ng-toggle]');
      expect(text(el, '[ng-toggled]')).toBe('Foo content.');

      // Click the content, verify the toggle does not close.
      click(el, '[ng-toggled]');
      expect(text(el, '[ng-toggled]')).toBe('Foo content.');
    }));
  });

  describe('show tests', function(){
    beforeEach(setup);

    it('works for simple toggles', inject(function($compile, $rootScope) {
      var el = angular.element('<div><div ng-toggle="foo">Foo</div><div ng-toggled-show="foo">Foo content.</div></div>');
      var scope = $rootScope.$new();
      el = $compile(el)(scope);
      scope.$apply();

      expect(q(el, '.ng-hide[ng-toggled-show]').length).toBe(1);
      click(el, '[ng-toggle]');
      expect(q(el, '.ng-hide[ng-toggled-show]').length).toBe(0);
      click(el, '[ng-toggle]');
      expect(q(el, '.ng-hide[ng-toggled-show]').length).toBe(1);
    }));
  })
})();
