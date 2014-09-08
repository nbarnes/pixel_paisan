$ ->

  mouse_loc =
    x: (e) -> e.pageX - $('#canvas').offset().left
    y: (e) -> e.pageY - $('#canvas').offset().top

  $('#canvas').mousedown (e) ->
    console.log('Mousedown at ' + e.pageX + ' ' + e.pageY)
    console.log('left offset of canvas = ' + $('#canvas').offset().left)
    console.log('left offset of mouse inside canvas = ' + mouse_loc.x(e))

  $('#canvas').mousemove (e) ->