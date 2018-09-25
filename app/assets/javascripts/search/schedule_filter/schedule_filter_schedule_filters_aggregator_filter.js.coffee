ScheduleFilterScheduleFiltersAggregatorFilter = ->
  (filters, option) ->
    all_schedule_filters = []

    for array in [filters.acceptsChildren, filters.shiftLocal1]
      for entry in array
          words = entry.split("_")
          for word, index in words
            words[index] = word.charAt(0).toUpperCase() + word.substr(1).toLowerCase();
          all_schedule_filters.push words.join(" ")

    if filters.afterSchool and all_schedule_filters.indexOf('After School') == -1
      all_schedule_filters.push 'After School'
    if filters.beforeSchool and all_schedule_filters.indexOf('Before School') == -1
      all_schedule_filters.push 'Before School'
    if filters.acceptDropins and all_schedule_filters.indexOf('Drop In') == -1
      all_schedule_filters.push 'Drop In'
    if filters.rotating and all_schedule_filters.indexOf('Variable/Flexible') == -1
      all_schedule_filters.push 'Variable/Flexible'
    if filters.open24Hours and all_schedule_filters.indexOf('Non-Traditional Hours') == -1
      all_schedule_filters.push 'Non-Traditional Hours'

    if option == 'has_one_option_selected'
      return all_schedule_filters.length < 2
    else
      return all_schedule_filters.join(', ')

ScheduleFilterScheduleFiltersAggregatorFilter.$inject = []

angular.module('CCR').filter('scheduleFiltersAggregator', ScheduleFilterScheduleFiltersAggregatorFilter)
