$ ->

  context = document.getElementById('canvas').getContext("2d")

  mouse_loc =
    x: (e) -> e.pageX - $('#canvas').offset.left
    y: (e) -> e.pageY - $('#canvas').offset.top

  window.grid_size = () ->
    $('#grid_size_field').val()

  window.cell_size = () ->
    $('#cell_size_field').val()

  window.cell_count_x = () ->
    $('#canvas').width() / grid_size()
  window.cell_count_y = () ->
    $('#canvas').height() / grid_size()

  window.draw_grid = () ->

  window.set_canvas_size = () ->
    $('#canvas').width(grid_size() * cell_size())
    $('#canvas').height(grid_size() * cell_size())
    $('#canvas_width').text($('#canvas').width())
    $('#canvas_height').text($('#canvas').height())

  window.draw_cell = (canvas_x, canvas_y) ->
    context.fillStyle = "red";
    target_x = cell_x_to_x ( x_to_cell_x(canvas_x) )
    target_y = cell_y_to_y ( y_to_cell_y(canvas_y) )
    alert('drawing at x = ' + target_x + ', y = ' + target_y)
    context.fillRect(200, 200, 20, 20)
    context.fillRect(target_x, target_y, cell_size(), cell_size())

  x_to_cell_x = (canvas_x) ->
    Math.floor( canvas_x / grid_size() )

  y_to_cell_y = (canvas_y) ->
    Math.floor( canvas_y / grid_size() )

  cell_x_to_x = (cell_x) ->
    Math.floor( cell_x * grid_size() )

  cell_y_to_y = (cell_y) ->
    Math.floor( cell_y * grid_size() )

  $('#cell_size_field').change () ->
    set_canvas_size()

  $('#grid_size_field').change () ->
    set_canvas_size()

  set_canvas_size()
  context.fillRect(200, 200, 20, 20)
