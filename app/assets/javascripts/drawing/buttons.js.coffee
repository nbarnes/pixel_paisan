$ ->
  $('#painting_application_panel').ready ->

    $('#canvas_clear_button').click (e) ->
      reset_drawing()

    $('#create_new_button').click (e) ->
      window.picture_id = undefined
      $('#picture_name_display').html('new_picture')
      reset_drawing()
