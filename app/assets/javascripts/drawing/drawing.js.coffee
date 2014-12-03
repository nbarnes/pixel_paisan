$ ->
  $('.front_page.welcome').ready ->

    window.trigger_cell = (canvas_x, canvas_y) ->
      target_cell = get_cell(canvas_x, canvas_y)
      if target_cell != null
        target_cell.trigger()
      else
        return null

    window.draw_cursor = (canvas_x, canvas_y) ->
      target_cell = get_cell(canvas_x, canvas_y)
      if target_cell != null
        target_cell.draw_cursor()
      else
        return null

    window.redraw_cell = (canvas_x, canvas_y) ->
      target_cell = get_cell(canvas_x, canvas_y)
      if target_cell != null
        target_cell.redraw()
      else
        return null

    get_cell = (canvas_x, canvas_y) ->
      cell_x = x_to_cell_x(canvas_x)
      cell_y = y_to_cell_y(canvas_y)
      if ((cell_x < cells.length) && (cell_y < cells[0].length))
        return cells[cell_x][cell_y]
      else
        return null

    x_to_cell_x = (canvas_x) ->
      Math.floor(canvas_x / cell_size())

    y_to_cell_y = (canvas_y) ->
      Math.floor(canvas_y / cell_size())