$ ->
  $('.front_page.welcome').ready ->

    $('#canvas_clear_button').click (e) ->
      reset_drawing()

    $('#create_new_button').click (e) ->
      window.picture_id = undefined
      reset_drawing()