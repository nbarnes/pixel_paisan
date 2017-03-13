
$('#painting_application_panel').ready ->
  window.Drawing = (->

    drawing_context = document.getElementById('painting_canvas').getContext("2d")

    paint_rect = (canvas_x, canvas_y, size, color) ->
      drawing_context.fillStyle = "rgba(#{color.r}, #{color.g}, #{color.b}, #{color.a})"
      if color.a == 0
        drawing_context.clearRect(canvas_x, canvas_y, size, size)
      else
        drawing_context.fillRect(canvas_x, canvas_y, size, size)

    dither_rect = (canvas_x, canvas_y, size) ->
      for x in [0...size]
        for y in [0...size]
          if ((x + y) % 2) == 0
            Drawing.paint_rect((canvas_x + x), (canvas_y + y), 1, {r: 64, g: 64, b: 64, a: 1})

    paint_cell = (canvas_x, canvas_y) ->
      target_cell = get_cell(canvas_x, canvas_y)
      if target_cell != null
        target_cell.paint_on(ColorSelection.get_current_color())
      else
        return null

    draw_cursor = (canvas_x, canvas_y) ->
      target_cell = get_cell(canvas_x, canvas_y)
      if target_cell != null
        target_cell.draw_cursor(ColorSelection.get_current_color())
      else
        return null

    redraw_cell = (canvas_x, canvas_y) ->
      target_cell = get_cell(canvas_x, canvas_y)
      if target_cell != null
        target_cell.redraw()
      else
        return null

    get_cell = (canvas_x, canvas_y) ->
      cell_x = Math.floor(canvas_x / cell_size())
      cell_y = Math.floor(canvas_y / cell_size())
      if ((cell_x < cells.length) && (cell_y < cells[0].length))
        return cells[cell_x][cell_y]
      else
        return null

    return {
      paint_rect: paint_rect
      dither_rect: dither_rect
      paint_cell: paint_cell
      draw_cursor: draw_cursor
      redraw_cell: redraw_cell
      get_cell: get_cell
    }

  )()
