$ ->
  $('#painting_application_panel').ready ->

    class window.Cell
      constructor: (@x, @y) ->
        @my_color = {r: 255, g: 255, b: 255, a: 0}

      trigger: ->
        old_color = @my_color
        @my_color = get_drawing_color()
        this.fill_rect()
        if colors_equal(old_color, @my_color)
          return null
        else
          return new UndoToken(old_color, this)

      redraw: ->
        old_color = get_drawing_color()
        set_drawing_color(@my_color)
        this.fill_rect()
        set_drawing_color(old_color)

      clear: () ->
        @my_color = {r: 255, g: 255, b: 255, a: 0}

      draw_cursor: ->
        this.fill_rect()

      undo: (old_color) ->
        @my_color = old_color
        this.redraw()

      import: (color) ->
        set_drawing_color(color)
        @my_color = get_drawing_color()
        this.fill_rect()

      fill_rect: ->
        color = get_drawing_color()

        target_x = cell_x_to_x ( @x )
        target_y = cell_y_to_y ( @y )

        debugger

        if $('#draw_grid_checkbox')[0].checked
          old_color = get_drawing_color()
          set_drawing_color({r: 128, g: 128, b: 128, a: 1})
          pp_context.fillRect(target_x, target_y, cell_size(), cell_size())
          set_drawing_color(old_color)
          if color.a == 0
            pp_context.clearRect(target_x, target_y, cell_size() - 1, cell_size() - 1)
          else if color.a > 0
            pp_context.fillRect(target_x, target_y, cell_size() - 1, cell_size() - 1)
        else
          if color.a == 0
            pp_context.clearRect(target_x, target_y, cell_size(), cell_size())
          else if color.a > 0
            pp_context.fillRect(target_x, target_y, cell_size(), cell_size())


    cell_x_to_x = (cell_x) ->
      cell_x * cell_size()

    cell_y_to_y = (cell_y) ->
      cell_y * cell_size()
