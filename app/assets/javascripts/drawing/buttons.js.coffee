$ ->
  $('#painting_application_panel').ready ->

    $('#canvas_clear_button').click (e) ->
      reset_drawing()

    $('#create_new_button').click (e) ->
      window.picture_id = undefined
      reset_drawing()

    $('#change_picture_name_button').click (e) ->
      new_name = window.prompt('Enter a new name for your picture', '')
      $('#picture_name_display').html(new_name)
