$ ->

  window.trigger_cell = (canvas_x, canvas_y) ->
    cell_x = x_to_cell_x ( canvas_x )
    cell_y = y_to_cell_y ( canvas_y )
    cells[cell_x][cell_y].trigger()

  x_to_cell_x = (canvas_x) ->
    Math.floor(canvas_x / cell_size())

  y_to_cell_y = (canvas_y) ->
    Math.floor(canvas_y / cell_size())