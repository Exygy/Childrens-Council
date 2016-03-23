$(document).on 'click', '.checkbox-button', (event) ->
  $(event.target).find('input').click()
