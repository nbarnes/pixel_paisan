$ ->
  $('#painting_application_panel').ready ->

    Picture.set_dimension(15);
    Picture.set_cell_size(24);

    Picture.set_picture_id($('#painting_application_panel').data('picture-id'))

    Painter.paint_canvas()

    Palettes.palette_selector_changed()

    $("#painting_canvas").focus()
