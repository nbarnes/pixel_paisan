$ ->
  $('#painting_application_panel').ready ->

    picture_id = $('#painting_application_panel').data('picture-id')

    if picture_id
      Picture.set_picture_id(picture_id)
    else
      Picture.set_dimension(25)
      Picture.set_cell_size(14)
      Canvas.resize_canvas_element(Picture.get_dimension(), Picture.get_cell_size())
      Painter.paint_canvas(Picture)
      Palettes.palette_selector_changed()

    $("#painting_canvas").focus()
