# Adapted from https://codepen.io/aorian/pen/bNVVpr
angular.module('CCR').directive('sticky', ['$window', ($window) ->
  stuckClass = 'stuck'
  stuckAtBottomClass = 'stuck-at-bottom'
  stickyDisabledClass = 'sticky-disabled'
  stickToBottomBuffer = 200

  link = (scope, element, attrs) ->
    windowEl = angular.element($window)

    if (scope.stickyElements == undefined)
      scope.stickyElements = []

      stick = (item) ->
        item.element.css('width', item.element[0].offsetWidth + 'px')
        item.element.addClass(stuckClass)
        item.element.css('top', '0px')
        item.isStuck = true
        if (item.placeholder)
          item.placeholder = angular.element('<div></div>')
                                    .css({height: item.element.outerHeight() + 'px'})
                                    .insertBefore(item.element)

      unstick = (item) ->
        item.element.removeClass(stuckClass)
        item.element.css('width', '100%')
        item.element.css('top', 'auto')
        item.isStuck = false
        if (item.placeholder)
          item.placeholder.remove()
          item.placeholder = true

      stickToBottom = (item) ->
        stuckAtBottomTop = item.scrollContainer.height() - item.element[0].offsetHeight
        item.element.addClass(stuckAtBottomClass)
        item.element.css('top', stuckAtBottomTop + 'px')
        item.isStuckAtBottom = true

      unstickFromBottom = (item) ->
        item.element.removeClass(stuckAtBottomClass)
        item.element.css('top', 'auto')
        item.isStuckAtBottom = false

      updateStickyElements = () ->
        pos = windowEl.scrollTop()

        scope.stickyElements.forEach((item) ->
          elementHeight = item.element[0].offsetHeight
          scrollContainerHeight = item.scrollContainer.height()
          item.topLimit = parseInt(item.topLimit)

          console.log('updateStickyElements')
          console.log(item.topLimit)
          console.log(elementHeight)
          console.log(item.element[0])
          console.log(scrollContainerHeight)

          if ((scrollContainerHeight - stickToBottomBuffer) <= elementHeight)
            console.log('unstick')
            unstick(item)
            unstickFromBottom(item)
          else if (!item.disabled)
            scrollContainerBottom = item.scrollContainerOffset + scrollContainerHeight
            itemBottom = pos + elementHeight

            if (item.isStuck)
              console.log('unstick - 1')
              if (pos < Math.min(item.start, item.topLimit))
                # Scroll is above the stuck element, so unstick it
                console.log('unstick - 2')
                unstick(item)
              else if (item.isStuck && itemBottom > scrollContainerBottom)
                # Element has reached bottom of scrollContainer, so stick it there
                console.log('unstick - 3')
                unstick(item)
                stickToBottom(item)
            else
              console.log('unstick - 5')
              if (item.isStuckAtBottom && pos <= item.element.offset().top)
                # Element was stuck at bottom of scrollContainer, scroll is
                # now high up enough to unstick it from bottom
                console.log('unstick - 5.1')
                unstickFromBottom(item)
                stick(item) && console.log('unstick - 5.7') if (pos >= Math.max(item.start, item.topLimit))
              else if (pos >= Math.max(item.start, item.topLimit) && !item.isStuckAtBottom)
                console.log('unstick - 5.5')
                # Scroll is past the element and it's not stuck, so stick the element
                stick(item)
        )

      debouncedUpdateStickyElements = _.debounce(
        (e) ->
          updateStickyElements()
        , 15)

      recheckDisabled = () ->
        scope.stickyElements.forEach((item) ->
          if (item.disabledBelowWidth)
            if (item.disabled && (windowEl.width() > item.disabledBelowWidth))
              item.element.removeClass(stickyDisabledClass)
              item.disabled = false
              item.scrollContainerOffset = item.scrollContainer.offset().top
            else if (!item.disabled && (windowEl.width() <= item.disabledBelowWidth))
              item.element.addClass(stickyDisabledClass)
              item.disabled = true
        )

      debouncedRecheckDisabled = _.debounce(
        (e) ->
          recheckDisabled()
        , 100)

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
      windowEl.on('scroll', debouncedUpdateStickyElements)
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

    scope.$watch 'providers', (oldValue, newValue) ->
      if (newValue)
        updateStickyElements()

  return {
    restrict: 'A'
    scope:
      providers: '<'
    link: link
  }
])

