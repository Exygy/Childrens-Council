# Adapted from https://codepen.io/aorian/pen/bNVVpr
angular.module('CCR').directive('sticky', ['$window', ($window) ->
  stuckClass = 'stuck'
  stuckAtBottomClass = 'stuck-at-bottom'

  link = (scope, element, attrs) ->
    windowEl = angular.element($window)

    if (scope.stickyElements == undefined)
      scope.stickyElements = []

      debouncedOnScroll = _.debounce(
        (e) ->
          pos = windowEl.scrollTop()

          scope.stickyElements.forEach((item) ->
            elementHeight = item.element[0].offsetHeight
            containerHeight = item.container.height()
            containerBottom = item.containerOffset + containerHeight
            itemBottom = pos + elementHeight
            stuckAtBottomTop = containerHeight - elementHeight

            # Element is stuck at bottom, but container height is now less than or
            # equal to the element height, so unstick it from the bottom
            if (item.isStuckAtBottom && containerHeight <= elementHeight)
              item.element.addClass(stuckClass);
              item.element.removeClass(stuckAtBottomClass);
              item.element.css('top', '0px')
              item.isStuckAtBottom = false

            # Scroll is past the element and it's not stuck, so stick the element
            if (!item.isStuck && pos > item.start)
              item.element.addClass('stuck')
              item.element.css('width', item.initialWidth + 'px')
              item.isStuck = true
              if (item.placeholder)
                item.placeholder = angular.element("<div></div>")
                                        .css({height: item.element.outerHeight() + "px"})
                                        .insertBefore(item.element)
            # Scroll is before the element and it is stuck, so unstick it
            else if (item.isStuck && pos < item.start)
              item.element.removeClass('stuck')
              item.isStuck = false
              item.element.css('width', '100%')
              if (item.placeholder)
                item.placeholder.remove()
                item.placeholder = true
            # Scroll is past where we want the element to stop being sticky, so unstick it
            # and set it to be relatively positioned at the bottom of the container
            else if (item.isStuck && itemBottom > containerBottom && !item.isStuckAtBottom)
              item.element.removeClass(stuckClass);
              item.element.addClass(stuckAtBottomClass);
              item.element.css('top', stuckAtBottomTop + 'px')
              item.isStuckAtBottom = true
            # Scroll is above where we want the element to stop being sticky, so stick it again
            else if (item.isStuckAtBottom && pos <= item.element.offset().top)
              item.element.addClass(stuckClass);
              item.element.removeClass(stuckAtBottomClass);
              item.element.css('top', '0px')
              item.isStuckAtBottom = false
          )
        , 20)

      windowEl.on('scroll', debouncedOnScroll)

      recheckPositions = () ->
        scope.stickyElements.forEach((el) ->
          if (!el.isStuck)
            el.start = el.element.offset().top
          else if (el.placeholder)
            el.start = el.placeholder.offset().top
        )

      windowEl.bind('load', recheckPositions)
      windowEl.bind('resize', recheckPositions)

    container = $('#' + attrs.stickyContainerId)

    stickyElement =
      container: container
      containerOffset: container.offset().top
      element: element
      initialHeight: element[0].offsetHeight
      initialWidth: element[0].offsetWidth
      isStuck: false
      isStuckAtBottom: false
      placeholder: attrs.usePlaceholder != undefined
      start: element.offset().top

    scope.stickyElements.push(stickyElement)

  return {
    restrict: 'A'
    link: link
  }
])

