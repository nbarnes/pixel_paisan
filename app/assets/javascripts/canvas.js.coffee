$ ->

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

  $('#cell_size_field').change () ->
    set_canvas_size()

  $('#grid_size_field').change () ->
    set_canvas_size()

  set_canvas_size()