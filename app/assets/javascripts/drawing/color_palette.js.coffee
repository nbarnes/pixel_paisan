$ ->

  $('#eraser_button').click (e) ->
    console.log(context.fillStyle)

  $('#red_button').click (e) ->
    set_color(255, 0, 0, 1)
  $('#green_button').click (e) ->
    set_color(0, 255, 0, 1)
  $('#blue_button').click (e) ->
    set_color(0, 0, 255, 1)
  $('#cyan_button').click (e) ->
    set_color(0, 255, 255, 1)
  $('#yellow_button').click (e) ->
    set_color(255, 255, 0, 1)
  $('#magenta_button').click (e) ->
    set_color(255, 0, 255, 1)

  window.set_color = (r, g, b, a) ->
    context.fillStyle = "rgba(#{r}, #{g}, #{b}, #{a})"
