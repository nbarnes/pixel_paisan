$ ->
  $('#painting_application_panel').ready ->

    class window.Cell
      constructor: (@x, @y) ->
        @my_color = {r: 255, g: 255, b: 255, a: 0}

      paint_on: (new_color) ->
        old_color = @my_color
        @my_color = new_color
        this.fill_rect(@my_color)
        if colors_equal(old_color, @my_color)
          return null
        else
          return new UndoToken(old_color, this)

      redraw: ->
        this.fill_rect(@my_color)

      clear: () ->
        @my_color = {r: 255, g: 255, b: 255, a: 0}

      draw_cursor: (cursor_color) ->
        this.fill_rect(cursor_color)

      undo: (old_color) ->
        @my_color = old_color
        this.redraw()

      import: (color) ->
        @my_color = color
        this.fill_rect(@my_color)

      fill_rect: (color) ->
        target_x = @x * cell_size()
        target_y = @y * cell_size()
        local_cell_size = cell_size()
        if $('#draw_grid_checkbox')[0].checked
          local_cell_size = local_cell_size - 1
          Drawing.paint_rect(target_x, target_y, cell_size(), {r: 128, g: 128, b: 128, a: 1})
        Drawing.paint_rect(target_x, target_y, local_cell_size, color)
        if color.a == 0
          Drawing.dither_rect(target_x, target_y, local_cell_size)
