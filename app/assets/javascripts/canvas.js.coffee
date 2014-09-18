$ ->

  window.context = document.getElementById('canvas').getContext("2d")

  window.mouse_loc =
    x: (e) -> e.pageX - $('#canvas').offset().left
    y: (e) -> e.pageY - $('#canvas').offset().top

  window.canvas_size_in_cells = () ->
    $('#canvas_size_in_cells_field').val()

  window.cell_size = () ->
    $('#cell_size_field').val()

  cell_count_x = () ->
    $('#canvas').width() / canvas_size_in_cells()
  cell_count_y = () ->
    $('#canvas').height() / canvas_size_in_cells()

  set_canvas_size = () ->
    new_size = canvas_size_in_cells() * cell_size()
    $('#canvas').attr({width: new_size, height: new_size })
    $('#canvas').width(new_size)
    $('#canvas').height(new_size)
    $('#canvas_width').text($('#canvas').width())
    $('#canvas_height').text($('#canvas').height())

  $('#cell_size_field').change () ->
    set_canvas_size()

  $('#grid_size_field').change () ->
    set_canvas_size()

  set_canvas_size()
