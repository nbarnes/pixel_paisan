$ ->
  $('#painting_application_panel').ready ->
    palette_sets = {}

    set_erase = (r, g, b, a, composite) ->
      set_drawing_color( {r: 255, g: 255, b: 255, a: 0} )

    window.set_drawing_color = (color) ->
      pp_context.fillStyle = "rgba(#{color.r}, #{color.g}, #{color.b}, #{color.a})"

    window.get_drawing_color = () ->
      color = fillStyle_into_color(pp_context.fillStyle)
      return color

    $('#erase_button').click (e) ->
      set_erase()

    $('#palette_selector').change (e) ->
      $('.palette_colors_set').hide()
      selected_palette_id = $( '#palette_selector option:selected' ).val()
      if palette_sets[selected_palette_id]
        palette_sets[selected_palette_id].show()
        palette_sets[selected_palette_id].find('.color_button').first().click()
      else
        $.getJSON "/palettes/#{selected_palette_id}", (data) ->
          load_palette(data)
          palette_sets[selected_palette_id].find('.color_button').first().click()

    load_palette = (palette) ->
      palette_colors_set = $('<div/>', { 'class':'palette_colors_set' })
      for i in [0...palette.colors.length]
        color = palette.colors[i]
        add_color_to_palette(color, palette_colors_set)
      $('#color_picker_opener').visible(palette['current_user_is_owner'])
      palette_colors_set.appendTo($('#palette_colors_wrapper'))
      palette_sets[palette.id] = palette_colors_set

    add_color_to_palette = (color, palette_colors_set) ->
      color_button = $('.templates .color_button').clone()
      color_button.attr('id', "color_button_r#{color.r}g#{color.g}b#{color.b}")
      color_button.css('background', "rgb(#{color.r},#{color.g},#{color.b})")
      color_button.bind 'click', get_click_handler(color)
      palette_colors_set.append(color_button)

    get_click_handler = (color) ->
      ->
        set_drawing_color(color)

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
      post_new_color_to_server($('#r_value_field').val(),
                               $('#g_value_field').val(),
                               $('#b_value_field').val())
      $.modal.close()

    post_new_color_to_server = (r_val, g_val, b_val) ->
      palette_id = $( '#palette_selector option:selected' ).val()
      payload = {
        palette_id: palette_id,
        r: r_val,
        g: g_val,
        b: b_val,
        a: 1
      }
      pixel_paisan_ajax
        url: "/palettes/#{palette_id}/create_color",
        verb: 'POST'
        data: payload
        success_callback: (data, textStatus, jqXHR) ->
          # console.log('AJAX posting of new color success')
          # console.log("Data = #{JSON.stringify(data, undefined, 2)}")
          add_color_to_palette({ r: data.r, g: data.g, b: data.b, a: data.a },
                                 palette_sets[palette_id])
        error_callback: (jqXHR, textStatus, errorThrown) ->
          console.log('AJAX posting of new color failure')
          console.log("#{JSON.stringify(jqXHR, undefined, 2)}")
          console.log("#{textStatus}")
          console.log("#{errorThrown}")

    fillStyle_into_color = (fillStyle) ->
      color = {}
      if fillStyle.charAt(0) == "#"
        hex = fillStyle.slice(1)
        bigint = parseInt(hex, 16)

        color.r = (bigint & 0xff0000) >> 16
        color.g = (bigint & 0x00ff00) >> 8
        color.b = bigint & 0x0000ff

        color.a = 1
      else if fillStyle.charAt(0) == "r"
        rgb_string = fillStyle.split(")")
        rgb_string = rgb_string[0].split("(")
        rgb_string = rgb_string[1].split(",")
        color.r = parseInt(rgb_string[0])
        color.g = parseInt(rgb_string[1])
        color.b = parseInt(rgb_string[2])
        color.a = parseFloat(rgb_string[3])

      return color

    window.colors_equal = (foo, bar) ->
      if foo.r == bar.r
        if foo.g == bar.g
          if foo.b == bar.b
            if foo.a == bar.a
              return true
      return false
