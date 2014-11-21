$ ->

  window.pp_context = document.getElementById('painting_canvas').getContext("2d")

  window.mouse_loc =
    x: (e) -> e.pageX - $('#painting_canvas').offset().left
    y: (e) -> e.pageY - $('#painting_canvas').offset().top

  window.cells = new Array

  window.canvas_size_in_cells = () ->
    $('#canvas_size_in_cells_field').val()

  window.cell_size = () ->
    $('#cell_size_field').val()

  resize_canvas_element = ->
    resize_cell_matrix()
    new_size = canvas_size_in_cells() * cell_size()
    change_canvas_attrs(new_size)
    $('#painting_canvas').width(new_size)
    $('#painting_canvas').height(new_size)
    $('#canvas_width').text($('#painting_canvas').width())
    $('#canvas_height').text($('#painting_canvas').height())

  resize_cell_matrix = ->
    for x in [0...canvas_size_in_cells()]
      unless cells[x]?
        cells[x] = new Array
      for y in [0...canvas_size_in_cells()]
        unless cells[x][y]?
          cells[x][y] = new Cell(x, y)

  window.reset_drawing = ->
    for x in [0...cells.length]
      for y in [0...cells.length]
        cells[x][y].clear()
    change_canvas_attrs($('#painting_canvas').attr('width'))

  # resizing / blanking the canvas also resets the fillStyle, so we
  # have to store the color for a moment and then reset it
  change_canvas_attrs = (new_size) ->
    old_color = get_drawing_color()
    $('#painting_canvas').attr({width: new_size, height: new_size})
    set_drawing_color = old_color

  redraw = ->
    for x in [0...canvas_size_in_cells()]
      for y in [0...canvas_size_in_cells()]
        cells[x][y].redraw()

  $('#canvas_size_in_cells_field').change () ->
    handle_canvas_size_field_changed($('#canvas_size_in_cells_field'))

  $('#cell_size_field').change () ->
    handle_canvas_size_field_changed($('#cell_size_field'))

  handle_canvas_size_field_changed = (canvas_size_input_element) ->
    if canvas_size_input_element.val() > 50
      canvas_size_input_element.val(50)
    resize_canvas_element()
    redraw()

  $('#canvas_size_in_cells_field').val('4')
  $('#cell_size_field').val('15')
  resize_canvas_element()
  $('#palette_selector').trigger('change')
  $("#painting_canvas").focus()
  set_drawing_color({r: 255, g: 0, b: 0, a: 1})
