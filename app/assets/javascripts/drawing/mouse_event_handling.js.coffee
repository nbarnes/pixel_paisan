$ ->
  $('#painting_application_panel').ready ->

    window.canvas_interaction_mode = 'draw'

    mouse_loc =
      x: (e) -> e.pageX - $('#painting_canvas').offset().left
      y: (e) -> e.pageY - $('#painting_canvas').offset().top

    my_mouse_down = false
    old_mouse_location = undefined
    undo_block = []

    $('#painting_canvas').mousedown (e) ->
      my_mouse_down = true
      old_mouse_location = e
      x = mouse_loc.x(e)
      y = mouse_loc.y(e)
      if canvas_interaction_mode == 'draw'
        undo_action = Painter.paint_cell(x, y)
        if undo_action != undefined
          undo_block.push( undo_action )
      else if canvas_interaction_mode == 'select'
        console.log('start drawing selection box')
        # start drawing selection box

    $('body').mouseup (e) ->
      mouse_depart()

    $('#painting_canvas').mouseleave (e) ->
      mouse_depart()
      # remove cursor from canvas if the mouse leaves
      if old_mouse_location != undefined
        old_x = mouse_loc.x(old_mouse_location)
        old_y = mouse_loc.y(old_mouse_location)
        Painter.remove_cursor(old_x, old_y)

    mouse_depart = () ->
      my_mouse_down = false
      if undo_block.length != 0
        Painter.add_undo_block(undo_block)
      undo_block = []
      return true

    $('#painting_canvas').mousemove (e) ->
      if old_mouse_location != undefined

        old_x = mouse_loc.x(old_mouse_location)
        old_y = mouse_loc.y(old_mouse_location)

        old_mouse_location = e

        new_x = mouse_loc.x(e)
        new_y = mouse_loc.y(e)

        if my_mouse_down
          brensenham_line_algorithm(old_x, old_y, new_x, new_y)
        else
          Painter.remove_cursor(old_x, old_y)
          Painter.draw_cursor(new_x, new_y)

    brensenham_line_algorithm = (start_x, start_y, end_x, end_y) ->

      current_x = start_x
      current_y = start_y

      delta_x = end_x - start_x
      slope_x = 1
      delta_y = end_y - start_y
      slope_y = 1

      if delta_x < 0
        slope_x = -1
        delta_x = -delta_x

      if delta_y < 0
        slope_y = -1
        delta_y = -delta_y

      delta_x = delta_x << 1
      delta_y = delta_y << 1

      if delta_y < delta_x
        fraction = delta_y - (delta_x>>1)
        while current_x != end_x
          if fraction >= 0
            current_y += slope_y
            fraction -= delta_x
          fraction += delta_y
          current_x += slope_x

          undo_action = Painter.paint_cell(current_x, current_y)
          if undo_action != undefined
            undo_block.push( undo_action )

      else
        fraction = delta_x - (delta_y>>1)
        while current_y != end_y
          if fraction >= 0
            current_x += slope_x
            fraction -= delta_y
          fraction += delta_x
          current_y += slope_y

          undo_action = Painter.paint_cell(current_x, current_y)
          if undo_action != undefined
            undo_block.push( undo_action )
