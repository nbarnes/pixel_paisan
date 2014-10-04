$ ->

  set_erase = (r, g, b, a, composite) ->
    pp_context.globalCompositeOperation = "destination-out";
    pp_context.fillStyle = "rgba(255, 255, 255, 1)"

  set_color = (r, g, b, a) ->
    pp_context.globalCompositeOperation = "source-over";
    pp_context.fillStyle = "rgba(#{r}, #{g}, #{b}, #{a})"

  $('#erase_button').click (e) ->
    set_erase()

  window.load_palette = (palette) ->
    $('#palette_colors').empty()
    for i in [0...palette.colors.length]
      color = palette.colors[i]
      add_color_to_palette(color)

  window.add_color_to_palette = (color) ->
      color_button = $('.templates .color_button').clone()
      [r, g, b, a] = [color.r, color.g, color.b, color.a]
      color_button.css('background-color', "rgb(#{r},#{g},#{b}")
      color_button.bind 'click', get_click_handler(r, g, b, a)
      $('#palette_colors').append(color_button)

  get_click_handler = (r, g, b, a) ->
    ->
      set_color(r, g, b, a)

  $('#palette_selector').change (e) ->
    selected_palette_id = $( '#palette_selector option:selected' ).val()
    $.getJSON "/palettes/#{selected_palette_id}", (data) ->
      load_palette(data)

  load_palette(pp_default_palette)


