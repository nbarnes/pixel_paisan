
$('#painting_application_panel').ready ->

  $('#new_picture_option').click ->
    Picture.new_picture()
    Painter.paint_canvas(Picture)
    history.pushState(null, null, '/editor')

  $('#save_picture_option').click ->
    if a_user_is_logged_in()
      ColdStorage.store_picture(PackingTape.pack_for_picture(Picture))
    else
      show_modal_pane('log_in_to_save_pane', true)

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

  $('#canvas_diemsnion_option').click ->

  $('#cell_size_option').click ->


  $('#draw_grid_option').click ->
    Painter.toggle_draw_grid()
    if Painter.get_draw_grid()
      $('#painting_canvas').css('border-bottom-width', '0')
      $('#painting_canvas').css('border-right-width', '0')
    else
      $('#painting_canvas').css('border-bottom-width', '1px')
      $('#painting_canvas').css('border-right-width', '1px')
    Painter.paint_canvas(Picture)
