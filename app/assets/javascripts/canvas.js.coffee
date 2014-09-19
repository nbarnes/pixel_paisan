$ ->

  window.context = document.getElementById('canvas').getContext("2d")

  window.mouse_loc =
    x: (e) -> e.pageX - $('#canvas').offset().left
    y: (e) -> e.pageY - $('#canvas').offset().top

  class Cell
    constructor: (@x, @y) ->

    trigger: (r, g, b, a) ->
      context.fillStyle = "rgba(#{r}, #{g}, #{b}, #{a})"
      target_x = cell_x_to_x ( @x )
      target_y = cell_y_to_y ( @y )
      context.fillRect(target_x, target_y, cell_size(), cell_size())

  window.cells = new Array

  window.canvas_size_in_cells = () ->
    $('#canvas_size_in_cells_field').val()

  window.cell_size = () ->
    $('#cell_size_field').val()

  cell_count_x = () ->
    $('#canvas').width() / canvas_size_in_cells()
  cell_count_y = () ->
    $('#canvas').height() / canvas_size_in_cells()

  set_canvas_size = () ->
    for x_index in [0...canvas_size_in_cells()]
      unless cells[x_index]?
        cells[x_index] = new Array
      for y_index in [0...canvas_size_in_cells()]
        unless cells[x_index][y_index]?
          cells[x_index][y_index] = new Cell(x_index, y_index)

    console.log("new cells matrix is " + cells.length + " by " + cells[0].length)
    new_size = canvas_size_in_cells() * cell_size()
    $('#canvas').attr({width: new_size, height: new_size })
    $('#canvas').width(new_size)
    $('#canvas').height(new_size)
    $('#canvas_width').text($('#canvas').width())
    $('#canvas_height').text($('#canvas').height())

  $('#cell_size_field').change () ->
    set_canvas_size()

  $('#canvas_size_in_cells_field').change () ->
    set_canvas_size()

  cell_x_to_x = (cell_x) ->
    cell_x * cell_size()

  cell_y_to_y = (cell_y) ->
    cell_y * cell_size()

  set_canvas_size()
