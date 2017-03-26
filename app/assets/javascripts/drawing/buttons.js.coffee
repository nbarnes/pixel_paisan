$ ->
  $('#painting_application_panel').ready ->

    $('#canvas_clear_button').click (e) ->
      Picture.clear()
      Painter.paint_canvas(Picture)

    $('#create_new_button').click (e) ->
      Picture.new_picture()
      Painter.paint_canvas(Picture)
      history.pushState(null, null, '/editor')

    $('#draw_grid_checkbox').change () ->
      grid_checked = $('#draw_grid_checkbox')[0].checked
      Painter.set_draw_grid(grid_checked)
      if grid_checked
        $('#painting_canvas').css('border-bottom-width', '0')
        $('#painting_canvas').css('border-right-width', '0')
      else
        $('#painting_canvas').css('border-bottom-width', '1px')
        $('#painting_canvas').css('border-right-width', '1px')
      Painter.paint_canvas(Picture)

    $('#undo_button').click () ->
      Painter.undo()

    $('#save_picture_button').click () ->
      if a_user_is_logged_in()
        ColdStorage.store_picture(PackingTape.pack_for_picture(Picture))
      else
        show_modal_pane('log_in_to_save_pane', true)

    $('#change_picture_name_button').click (e) ->
      new_picture_name = window.prompt('Enter a new name for your picture', '')
      new_picture_name = massage_picture_name new_picture_name
      if not new_picture_name
        set_picture_name_display('unnamed_picture')
      Picture.set_name(new_picture_name)

    $('#erase_button').click (e) ->
      ColorSelection.set_current_color( {r: 255, g: 255, b: 255, a: 0} )

    $('#palette_selector').change (e) ->
      Palettes.palette_selector_changed()

    $("#previous_color_pane").click () ->
      ColorSelection.set_current_color(ColorSelection.get_previous_color())

    $("#color_picker_opener").click () ->
      $("#color_picker_modal").modal({overlayClose: true})

    $(".color_value_field").change () ->
      new_r = $('#r_value_field').val()
      new_g = $('#g_value_field').val()
      new_b = $('#b_value_field').val()
      new_color = "rgb(#{new_r}, #{new_g}, #{new_b})"
      # console.log(new_color)
      $("#color_display_panel").css('background-color', new_color)

    $("#add_new_color_button").click () ->
      Palettes.add_new_color_to_palette($('#r_value_field').val(), $('#g_value_field').val(), $('#b_value_field').val())
      $.modal.close()
