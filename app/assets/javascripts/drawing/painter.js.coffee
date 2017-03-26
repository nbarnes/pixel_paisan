$('#painting_application_panel').ready ->
  window.Painter = (->

    undo_stack = []
    last_cursor = {x: undefined, y: undefined}
    draw_grid = false

    get_cell_coordinates = (canvas_x, canvas_y) ->
      cell_size = Picture.get_cell_size()
      cell_coordinates_x = Math.floor(canvas_x / cell_size)
      cell_coordinates_y = Math.floor(canvas_y / cell_size)
      return {x: cell_coordinates_x, y: cell_coordinates_y}

    add_undo_block = (undo_block) ->
      undo_stack.push(undo_block)

    undo = (old_color, cell_x, cell_y) ->
      if undo_stack.length > 0
        cell_size = Picture.get_cell_size()
        undo_block = undo_stack.pop()
        for undo_action in undo_block
          if undo_action != undefined
            Picture.get_cell(undo_action.x, undo_action.y).paint(undo_action.color);
            draw_cell(undo_action.x, undo_action.y, cell_size, undo_action.color)

    redo = ->
      # TODO

    get_draw_grid = ->
      return draw_grid

    set_draw_grid = (new_should_draw_grid) ->
      draw_grid = new_should_draw_grid

    draw_cursor = (canvas_x, canvas_y) ->
      cell_coordinates = get_cell_coordinates(canvas_x, canvas_y)
      draw_cell(cell_coordinates.x, cell_coordinates.y, Picture.get_cell_size(), ColorSelection.get_current_color())

    remove_cursor = (canvas_x, canvas_y) ->
      cell_coordinates = get_cell_coordinates(canvas_x, canvas_y)
      cell = Picture.get_cell(cell_coordinates.x, cell_coordinates.y)
      if cell
        cell_size = Picture.get_cell_size()
        draw_cell(cell_coordinates.x, cell_coordinates.y, cell_size, cell.get_color())

    paint_cell = (canvas_x, canvas_y) ->
      cell_coordinates = get_cell_coordinates(canvas_x, canvas_y)
      cell = Picture.get_cell(cell_coordinates.x, cell_coordinates.y)
      if cell
        old_color = cell.paint(ColorSelection.get_current_color())
        cell_size = Picture.get_cell_size()
        draw_cell(cell_coordinates.x, cell_coordinates.y, cell_size, cell.get_color())
        if old_color
          return new UndoToken(old_color, cell_coordinates.x, cell_coordinates.y)

    draw_cell = (cell_x, cell_y, cell_size, color) ->
      target_x = cell_x * cell_size
      target_y = cell_y * cell_size
      if draw_grid
        Canvas.paint_rect(target_x, target_y, Picture.get_cell_size(), {r: 64, g: 64, b: 64, a: 1})
        Canvas.paint_rect(target_x , target_y, Picture.get_cell_size() - 1, color)
      else
        Canvas.paint_rect(target_x, target_y, Picture.get_cell_size(), color)

    paint_canvas = (picture) ->
      dimension = picture.get_dimension()
      for x in [0...dimension]
        for y in [0...dimension]
          color = picture.get_cell(x, y).get_color()
          cell_size = picture.get_cell_size()
          draw_cell(x, y, cell_size, color)

    return {
      add_undo_block: add_undo_block
      undo: undo
      redo: redo
      get_draw_grid: get_draw_grid
      set_draw_grid: set_draw_grid
      draw_cursor: draw_cursor
      remove_cursor: remove_cursor
      paint_cell: paint_cell
      paint_canvas: paint_canvas
    }

  )()
