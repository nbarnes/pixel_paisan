$ ->

  class window.Cell
    constructor: (@x, @y) ->
      @my_fillStyle = "rgba(255, 255, 255, 1)"

    trigger: ->
      old_fillStyle = @my_fillStyle
      @my_fillStyle = pp_context.fillStyle
      fill_rect(@x, @y)
      if old_fillStyle != pp_context.fillStyle
        return new UndoToken(old_fillStyle, this)
      else
        return null

    redraw: ->
      old_fillStyle = pp_context.fillStyle
      pp_context.fillStyle = @my_fillStyle
      fill_rect(@x, @y)
      pp_context.fillStyle = old_fillStyle

    clear: () ->
      @my_fillStyle = "rgba(255, 255, 255, 1)"

    draw_cursor: ->
      fill_rect(@x, @y)

    undo: (old_fillStyle) ->
      @my_fillStyle = old_fillStyle
      this.redraw()

    fill_rect = (x, y) ->
      target_x = cell_x_to_x ( x )
      target_y = cell_y_to_y ( y )
      pp_context.fillRect(target_x, target_y, cell_size(), cell_size())



  cell_x_to_x = (cell_x) ->
    cell_x * cell_size()

  cell_y_to_y = (cell_y) ->
    cell_y * cell_size()