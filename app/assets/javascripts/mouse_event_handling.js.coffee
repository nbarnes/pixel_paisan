$ ->

  mouse_down = false

  $('#canvas').mousedown (e) ->
    mouse_down = true

  $('body').mouseup (e) ->
    mouse_down = false

  $('#canvas').mousemove (e) ->
    if mouse_down
      x = mouse_loc.x(e)
      y = mouse_loc.y(e)
      trigger_cell(mouse_loc.x(e), mouse_loc.y(e))