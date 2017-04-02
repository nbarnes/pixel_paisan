
window.Canvas = (->

  drawing_context = ->
    return document.getElementById('painting_canvas').getContext("2d")

  resize_canvas_element = (dimension, cell_size) ->
    new_size = dimension * cell_size
    $('#painting_canvas').attr({width: new_size, height: new_size})
    $('#painting_canvas').width(new_size)
    $('#painting_canvas').height(new_size)
    $('#canvas_holder').width(new_size)
    $('#canvas_dimension_display').text("#{dimension}x#{dimension}, pixel size #{cell_size}px")
    Painter.paint_canvas(Picture)

  paint_rect = (canvas_x, canvas_y, size, color) ->
    if color.a == 0
      dither_rect(canvas_x, canvas_y, size)
    else
      drawing_context().fillStyle = "rgba(#{color.r}, #{color.g}, #{color.b}, #{color.a})"
      drawing_context().fillRect(canvas_x, canvas_y, size, size)

  dither_rect = (canvas_x, canvas_y, size) ->
    drawing_context().clearRect(canvas_x, canvas_y, size, size)
    for x in [0...size]
      for y in [0...size]
        if ((x + y) % 2) == 0
          paint_rect((canvas_x + x), (canvas_y + y), 1, {r: 64, g: 64, b: 64, a: 1})

  return {
    resize_canvas_element: resize_canvas_element
    paint_rect: paint_rect
  }

)()
