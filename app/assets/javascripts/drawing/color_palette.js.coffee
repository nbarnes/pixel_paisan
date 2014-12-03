$ ->
  $('.front_page.welcome').ready ->

    set_erase = (r, g, b, a, composite) ->
      set_drawing_color( {r: 255, g: 255, b: 255, a: 0} )

    window.set_drawing_color = (color) ->
      pp_context.fillStyle = "rgba(#{color.r}, #{color.g}, #{color.b}, #{color.a})"

    window.get_drawing_color = () ->
      color = fillStyle_into_color(pp_context.fillStyle)
      return color

    $('#erase_button').click (e) ->
      set_erase()

    window.load_palette = (palette) ->
      $('#palette_colors').empty()
      for i in [0...palette.colors.length]
        color = palette.colors[i]
        add_color_to_palette(color)

    window.add_color_to_palette = (color) ->
        color_button = $('.templates .color_button').clone()
        color_button.css('background-color', "rgb(#{color.r},#{color.g},#{color.b}")
        color_button.bind 'click', get_click_handler(color)
        $('#palette_colors').append(color_button)

    get_click_handler = (color) ->
      ->
        set_drawing_color(color)

    $('#palette_selector').change (e) ->
      selected_palette_id = $( '#palette_selector option:selected' ).val()
      $.getJSON "/palettes/#{selected_palette_id}", (data) ->
        load_palette(data)

    fillStyle_into_color = (fillStyle) ->
      color = {}
      if fillStyle.charAt(0) == "#"
        hex = fillStyle.slice(1)
        bigint = parseInt(hex, 16)

        color.r = (bigint & 0xff0000) >> 16;
        color.g = (bigint & 0x00ff00) >> 8;
        color.b = bigint & 0x0000ff;

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

      # return (foo.r == bar.r) && (foo.g == bar.g) && (foo.b == bar.b) && (foo.a == bar.a)

