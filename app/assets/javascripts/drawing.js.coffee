$ ->

  window.draw_cell = (canvas_x, canvas_y) ->
    context.fillStyle = "red";
    cell_x = x_to_cell_x ( canvas_x )
    cell_y = y_to_cell_y ( canvas_y )
    target_x = cell_x_to_x ( x_to_cell_x(canvas_x) )
    target_y = cell_y_to_y ( y_to_cell_y(canvas_y) )
    context.fillRect(target_x, target_y, cell_size(), cell_size())

  x_to_cell_x = (canvas_x) ->
    Math.floor(canvas_x / cell_size())

  y_to_cell_y = (canvas_y) ->
    Math.floor(canvas_y / cell_size())

  cell_x_to_x = (cell_x) ->
    cell_x * cell_size()

  cell_y_to_y = (cell_y) ->
    cell_y * cell_size()