$ ->

  class window.Cell
    constructor: (@x, @y) ->
      @my_fillStyle = "rgba(255, 255, 255, 1)"

    trigger: ->
      target_x = cell_x_to_x ( @x )
      target_y = cell_y_to_y ( @y )
      @my_fillStyle = pp_context.fillStyle
      pp_context.fillRect(target_x, target_y, cell_size(), cell_size())

    redraw: ->
      target_x = cell_x_to_x ( @x )
      target_y = cell_y_to_y ( @y )
      old_fillStyle = pp_context.fillStyle
      pp_context.fillStyle = @my_fillStyle
      pp_context.fillRect(target_x, target_y, cell_size(), cell_size())
      pp_context.fillStyle = old_fillStyle

    clear: () ->
      @my_fillStyle = "rgba(255, 255, 255, 1)"

    draw_cursor: ->
      target_x = cell_x_to_x ( @x )
      target_y = cell_y_to_y ( @y )
      pp_context.fillRect(target_x, target_y, cell_size(), cell_size())

  cell_x_to_x = (cell_x) ->
    cell_x * cell_size()

  cell_y_to_y = (cell_y) ->
    cell_y * cell_size()