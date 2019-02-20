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
            if (!item.stickyDisabled)
              elementHeight = item.element[0].offsetHeight
              scrollContainerHeight = item.scrollContainer.height()
              scrollContainerBottom = item.scrollContainerOffset + scrollContainerHeight
              itemBottom = pos + elementHeight
              stuckAtBottomTop = scrollContainerHeight - elementHeight

              # Element is stuck at bottom, but scrollContainer height is now less than or
              # equal to the element height, so unstick it from the bottom
              if (item.isStuckAtBottom && scrollContainerHeight <= elementHeight)
                item.element.addClass(stuckClass);
                item.element.removeClass(stuckAtBottomClass);
                item.element.css('top', '0px')
                item.isStuckAtBottom = false

              # Scroll is past the element and it's not stuck, so stick the element
              if (!item.isStuck && pos > Math.max(item.start, item.topLimit))
                item.element.css('width', item.element[0].offsetWidth + 'px')
                item.element.addClass('stuck')
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
              # and set it to be relatively positioned at the bottom of the scrollContainer
              else if (item.isStuck && itemBottom > scrollContainerBottom && !item.isStuckAtBottom)
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
        , 15)

      recheckDisabled = () ->
        scope.stickyElements.forEach((item) ->
          if (item.disabledBelowWidth)
            if (item.disabled && (windowEl.width() > item.disabledBelowWidth))
              item.element.removeClass('sticky-disabled')
              item.disabled = false
              item.scrollContainerOffset = item.scrollContainer.offset().top
            else if (!item.disabled && (windowEl.width() <= item.disabledBelowWidth))
              item.element.addClass('sticky-disabled')
              item.disabled = true
        )

      debouncedRecheckDisabled = _.debounce(
        (e) ->
          recheckDisabled()
        , 110)

      recheckPositions = () ->
        scope.stickyElements.forEach((item) ->
          if (!item.disabled)
            if (!item.isStuck)
              item.start = item.element.offset().top
            else if (item.placeholder)
              item.start = item.placeholder.offset().top
        )

      recheckWidths = () ->
        scope.stickyElements.forEach((item) ->
          if (!item.disabled && item.isStuck && item.container)
            containerWidth = item.container.width()
            item.element.css('width', containerWidth + 'px')
        )

      windowEl.bind('load', recheckDisabled)
      windowEl.on('scroll', debouncedOnScroll)
      windowEl.on('resize', debouncedRecheckDisabled)
      windowEl.bind('resize', recheckPositions)
      windowEl.bind('resize', recheckWidths)

    container = $('#' + attrs.stickyContainerId)
    scrollContainer = $('#' + attrs.stickyScrollContainerId)

    stickyElement =
      container: container
      disabled: false
      disabledBelowWidth: attrs.stickyDisabledBelowWidth
      element: element
      initialHeight: element[0].offsetHeight
      isStuck: false
      isStuckAtBottom: false
      placeholder: attrs.usePlaceholder != undefined
      scrollContainer: scrollContainer
      scrollContainerOffset: scrollContainer.offset().top
      start: element.offset().top
      topLimit: attrs.stickyTopLimit

    scope.stickyElements.push(stickyElement)

  return {
    restrict: 'A'
    link: link
  }
])

