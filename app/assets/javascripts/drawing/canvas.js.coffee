$ ->

  window.context = document.getElementById('canvas').getContext("2d")

  window.mouse_loc =
    x: (e) -> e.pageX - $('#canvas').offset().left
    y: (e) -> e.pageY - $('#canvas').offset().top

  window.cells = new Array

  window.canvas_size_in_cells = () ->
    $('#canvas_size_in_cells_field').val()

  window.cell_size = () ->
    $('#cell_size_field').val()

  window.set_canvas_size = () ->
    for x in [0...canvas_size_in_cells()]
      unless cells[x]?
        cells[x] = new Array
      for y in [0...canvas_size_in_cells()]
        unless cells[x][y]?
          cells[x][y] = new Cell(x, y)

    new_size = canvas_size_in_cells() * cell_size()
    $('#canvas').attr({width: new_size, height: new_size })
    $('#canvas').width(new_size)
    $('#canvas').height(new_size)
    $('#canvas_width').text($('#canvas').width())
    $('#canvas_height').text($('#canvas').height())

    redraw_cells()

  redraw_cells = () ->
    for x in [0...canvas_size_in_cells()]
      for y in [0...canvas_size_in_cells()]
        cells[x][y].trigger()

  window.clear_canvas = () ->
    for x in [0...cells.length]
      for y in [0...cells.length]
        cells[x][y].clear()

    # one blanks the underlying canvas element by resetting its
    # HTML attribute size without an actual delta
    new_size = canvas_size_in_cells() * cell_size()
    $('#canvas').attr({width: new_size, height: new_size })

  $('#cell_size_field').change () ->
    set_canvas_size()

  $('#canvas_size_in_cells_field').change () ->
    set_canvas_size()

  set_canvas_size()
