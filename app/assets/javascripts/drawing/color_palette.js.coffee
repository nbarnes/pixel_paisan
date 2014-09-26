$ ->

  set_erase = (r, g, b, a, composite) ->
    context.globalCompositeOperation = "destination-out";
    context.fillStyle = "rgba(255, 255, 255, 1)"

  set_color = (r, g, b, a) ->
    context.globalCompositeOperation = "source-over";
    context.fillStyle = "rgba(#{r}, #{g}, #{b}, #{a})"

  $('#erase_button').click (e) ->
    set_erase()

  window.load_palette = (palette) ->

    for i in [0...palette.colors.length]
      color = palette.colors[i]
      color_button = $('.templates .color_button').clone()

      [r, g, b, a] = [color.r, color.g, color.b, color.a]
      color_button.css('background-color', "rgb(#{r},#{g},#{b}")
      color_button.bind 'click', get_click_handler(r, g, b, a)

      $('#palette_pane').append(color_button)


  get_click_handler = (r, g, b, a) ->
    ->
      set_color(r, g, b, a)


