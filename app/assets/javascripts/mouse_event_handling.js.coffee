->

  mouse_down = false

  $('#canvas').mousedown (e) ->
    mouse_down = true
    console.log('position.x of mouse inside canvas = ' + mouse_loc.x(e))

  $('#canvas').mouseup (e) ->
    mouse_down = false

  $('#canvas').mousemove (e) ->
    if mouse_down
      console.log('drawing')


