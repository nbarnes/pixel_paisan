$ ->
  $('#painting_application_panel').ready ->

    $('#canvas_clear_button').click (e) ->
      reset_drawing()

    $('#create_new_button').click (e) ->
      window.picture_id = undefined
      $('#tool_bar_file_element').html('new_picture')
      history.pushState(null, null, '/editor')
      reset_drawing()
