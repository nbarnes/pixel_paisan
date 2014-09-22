$ ->

  set_erase = (r, g, b, a, composite) ->
    context.globalCompositeOperation = "destination-out";
    context.fillStyle = "rgba(255, 255, 255, 1)"

  set_color = (r, g, b, a) ->
    context.globalCompositeOperation = "source-over";
    context.fillStyle = "rgba(#{r}, #{g}, #{b}, #{a})"

  $('#erase_button').click (e) ->
    set_erase()


  $('#aqua_button').click (e) ->
    set_color(0, 255, 255, 1)
  $('#black_button').click (e) ->
    set_color(0, 0, 0, 1)
  $('#blue_button').click (e) ->
    set_color(0, 0, 255, 1)
  $('#fuchsia_button').click (e) ->
    set_color(255, 0, 255, 1)
  $('#gray_button').click (e) ->
    set_color(128, 128, 128, 1)
  $('#green_button').click (e) ->
    set_color(0, 128, 0, 1)
  $('#lime_button').click (e) ->
    set_color(0, 255, 0, 1)
  $('#maroon_button').click (e) ->
    set_color(128, 0, 0, 1)
  $('#navy_button').click (e) ->
    set_color(0, 0, 128, 1)
  $('#olive_button').click (e) ->
    set_color(128, 128, 0, 1)
  $('#orange_button').click (e) ->
    set_color(255, 165, 0, 1)
  $('#purple_button').click (e) ->
    set_color(128, 0, 128, 1)
  $('#red_button').click (e) ->
    set_color('255, 0, 0, 1')
  $('#silver_button').click (e) ->
    set_color(192, 192, 192, 1)
  $('#teal_button').click (e) ->
    set_color(0, 128, 128, 1)
  $('#white_button').click (e) ->
    set_color(255, 255, 255, 1)
  $('#yellow_button').click (e) ->
    set_color(255, 255, 0, 1)
