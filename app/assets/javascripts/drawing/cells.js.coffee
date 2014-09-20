$ ->

  class window.Cell
    constructor: (@x, @y) ->
      [@r, @g, @b, @a] = [0, 0, 0, 0]

    trigger: (r, b, g, a) ->
      @r = r if r?
      @g = g if g?
      @b = b if b?
      @a = a if a?
      context.fillStyle = "rgba(#{@r}, #{@g}, #{@b}, #{@a})"
      target_x = cell_x_to_x ( @x )
      target_y = cell_y_to_y ( @y )
      context.fillRect(target_x, target_y, cell_size(), cell_size())

    clear: () ->
      [@r, @g, @b, @a] = [0, 0, 0, 0]

  cell_x_to_x = (cell_x) ->
    cell_x * cell_size()

  cell_y_to_y = (cell_y) ->
    cell_y * cell_size()