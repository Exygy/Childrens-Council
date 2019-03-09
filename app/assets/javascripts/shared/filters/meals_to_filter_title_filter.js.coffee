MealsToFilterTitleFilter = () ->
  (meals) ->
    if meals && meals.length
      if meals[0] == 'No meals'
        'No'
      else
        'Yes'
    else
      'Any'

angular.module('CCR').filter('mealsToFilterTitle', MealsToFilterTitleFilter)
