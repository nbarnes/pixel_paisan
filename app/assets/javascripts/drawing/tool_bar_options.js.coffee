$ ->
  $('#painting_application_panel').ready ->

    $('#new_picture_option').click ->
      Picture.new_picture()
      Painter.paint_canvas(Picture)
      history.pushState(null, null, '/editor')

    $('#save_picture_option').click ->
      if a_user_is_logged_in()
        ColdStorage.store_picture(PackingTape.pack_for_picture(Picture))
      else
        show_modal('login_in_to_save_modal', true)

    $('#rename_picture_option').click ->
      new_picture_name = window.prompt('Enter a new name for your picture', '')
      new_picture_name = massage_picture_name new_picture_name
      if not new_picture_name
        new_picture_name = 'unnamed_picture'
      Picture.set_name(new_picture_name)

    $('#clear_picture_option').click ->
      Picture.clear()
      Painter.paint_canvas(Picture)

    $('#undo_option').click ->
      Painter.undo()

    $('#redo_option').click ->
      console.log('TODO')

    $('#canvas_dimension_option').click ->
      new_dimension = massage_to_number(
        window.prompt('Enter a new size for your picture', '50')
      )
      if new_dimension > 100 || new_dimension < 2
        new_dimension = 100
      Picture.set_dimension(new_dimension)

    $('#cell_size_option').click ->
      new_cell_size = massage_to_number(
        window.prompt('Enter a new pixel size for your picture', '10')
      )
      if new_cell_size > 30 || new_cell_size < 1
        new_cell_size = 30
      Picture.set_cell_size(new_cell_size)

    $('#draw_grid_option').click ->
      Painter.toggle_draw_grid()
      if Painter.get_draw_grid()
        $('#painting_canvas').css('border-bottom-width', '0')
        $('#painting_canvas').css('border-right-width', '0')
      else
        $('#painting_canvas').css('border-bottom-width', '1px')
        $('#painting_canvas').css('border-right-width', '1px')
      Painter.paint_canvas(Picture)

    $('#dither_transparency_option').click ->
      console.log('TODO')

    $('#selection_tool_option').click ->
      canvas_interaction_mode = 'select'
