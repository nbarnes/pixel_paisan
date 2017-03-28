$ ->
  $('#painting_application_panel').ready ->

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
