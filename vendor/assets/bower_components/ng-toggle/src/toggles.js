/**
 * @license ng-toggle v0.1.0
 * (c) 2015 Zach Snow http://zachsnow.com
 * License: MIT
 */
(function(){
  var module = angular.module('toggles', []);
  
  module.factory('toggles', [
    '$document',
    '$rootScope',
    function($document, $rootScope){
      // Only un-toggle auto-close toggles.
      $document.on('click', function(e){
        var $target = angular.element(e.target);

        // Don't let clicks within toggles or toggleds to autoclose.
        var $node = $target;
        while($node.length){
          if($node.attr('ng-toggle') || $node.attr('ng-toggled') || $node.attr('ng-toggled-show')){
            return;
          }
          $node = angular.element($node.parent());
        }
        
        // Also don't let clicks on things that aren't in the DOM auto-close.
        // This fixes issues where you click on something, and its click handler
        // fires before the click reaches the <html /> and removes the thing
        // you clicked on (like starting to edit something, where the edit button
        // changes into the form). When that happens, we can no longer determine
        // that you clicked in a toggle, so we err on the side of caution.
        if(!$document[0].documentElement.contains(e.target)){
          return;
        }

        // Close all auto-close toggles.
        $rootScope.$apply(function(){
          var toggle;
          for(var key in service.toggles){
            toggle = service.toggles[key];
            if(toggle.autoClose){
              toggle.state = false
            }
          }
        });
      });
      
      var service = {
        toggles: {},
        
        create: function(name, options){
          // Create toggle if necessary; this allows us to put the ng-toggled before the ng-toggle
          // in the DOM, or create multiple ng-toggles for a single ng-toggled and vice versa.
          var toggle = service.toggles[name];
          if(toggle){
            toggle.count += 1;
            return;
          }

          // Nicer defaults.
          var closeable = options.closeable !== undefined ? !!options.closeable : true;
          if(options.autoClose && !closeable){
            throw new Error('toggles: toggle cannot be auto-close without being closeable: ' + name);
          }
          var defaultState = closeable ? !!options.defaultState :  true;

          toggle = {
            state: defaultState,
            group: options.group || null,
            autoClose: options.autoClose || false,
            closeable: closeable,
            count: 1
          };
          service.toggles[name] = toggle;
          
          // Watch this toggle's state and close toggles in the same group when it is opened;
          // only do it when the toggle is in a group.
          if(toggle.group){
            toggle.deregisterGroupWatch = $rootScope.$watch(function toggleGroupWatch(){
              return toggle.state;
            }, function toggleGroupWatchHandler(state){
              var otherToggle;
              if(!state){
                return;
              }
              for(var key in service.toggles){
                otherToggle = service.toggles[key];
                if(toggle !== otherToggle && toggle.group === otherToggle.group){
                  otherToggle.state = false;
                }
              };
            });
          }
        },
        
        destroy: function(name){
          var toggle = service.toggles[name];
          if(!toggle){
            console.warn('ng-toggle: destroying invalid toggle', name);
            return;
          }
          toggle.count -= 1;
          if(!toggle.count){
            toggle.deregisterGroupWatch && toggle.deregisterGroupWatch(); 
            delete service.toggles[name];
          }
        },
        
        toggle: function(name, value){
          var toggle = service.toggles[name];
          if(!toggle){
            console.warn('ng-toggle: toggling invalid toggle', name);
            return;
          }

          // If you pass a value use that as the new state, otherwise
          // just invert the current state.
          value = arguments.length > 1 ? !!value : !toggle.state;

          // Can't close uncloseable toggles.
          if(!toggle.closeable){
            value = true;
          }

          toggle.state = value;
        },
        
        state: function(name){
          var toggle = service.toggles[name];
          if(!toggle){
            return false;
          }
          return toggle.state;
        }
      };
      
      return service;
    }
  ]);

  module.directive('ngToggle', [
    '$interpolate',
    '$parse',
    '$rootScope',
    'toggles',
    function($interpolate, $parse, $rootScope, toggles){
      var isSetFn = function(value, always){
        if(!value){
          return function(){
            return always || (value === '');
          };
        }
        else {
          return $parse(value);
        }
      };

      return {
        restrict: 'A',
        compile: function($element, $attrs){
          var nameFn = $interpolate($attrs.ngToggle || '');
          var groupFn = $interpolate($attrs.ngToggleGroup || '');
          var defaultFn = isSetFn($attrs.ngToggleDefault);
          var autoCloseFn = isSetFn($attrs.ngToggleAutoClose);
          var closeableFn = isSetFn($attrs.ngToggleCloseable, true);

          return function(scope, element, attrs){
            var name = nameFn(scope);
            if(!name){
              throw new Error('ng-toggle: invalid toggle name');
            }

            var defaultState = defaultFn(scope) || false;
            var group = groupFn(scope) || '';
            var autoClose = autoCloseFn(scope);
            var closeable = closeableFn(scope);

            // Create the toggle.
            toggles.create(name, {
              autoClose: autoClose,
              defaultState: defaultState,
              group: group,
              closeable: closeable
            });

            // Bind the event to toggle.
            element.on('click', function(){
              scope.$apply(function(){
                toggles.toggle(name);
              });
            });

            // Get stylin'.
            scope.$watch(function(){
              return toggles.state(name);
            }, function(state){
              element.toggleClass('toggled', state);
            });

            scope.$on('$destroy', function(){
              toggles.destroy(name);
            });
          };
        }
      };
    }
  ]);

  module.directive('ngToggled', [
    '$animate',
    '$interpolate',
    'toggles',
    function($animate, $interpolate, toggles){
      return {
        restrict: 'A',
        priority: 1000,
        transclude: true,
        compile: function($element, $attrs, $transclude){
          var nameFn = $interpolate($attrs.ngToggled);


          return function(scope, element, attrs, ctrl){
            var childElement, childScope;
            var name = nameFn(scope);
            var toggleState = function(){
              return toggles.state(name);
            };

            scope.$watch(toggleState, function ngToggledWatch(state){
              if(childElement){
                $animate.leave(childElement);
                childElement = undefined;
              }
              if(childScope){
                childScope.$destroy();
                childScope = undefined;
              }

              if(state){
                childScope = scope.$new();
                $transclude(childScope, function(clone){
                  childElement = clone;
                  $animate.enter(clone, element.parent(), element);
                });
              }
            });
          };
        }
      };
    }
  ]);

  module.directive('ngToggledShow', [
    '$interpolate',
    'toggles',
    function($interpolate, toggles){
      return {
        compile: function($element, $attrs){
          var nameFn = $interpolate($attrs.ngToggledShow);
          return function(scope, element){
            var name = nameFn(scope);
            scope.$watch(function ngToggledShowWatch(){
              return toggles.state(name);
            }, function(toggled){
              element.toggleClass('ng-hide', !toggled);
            });
          };
        }
      };
    }
  ]);
})();
