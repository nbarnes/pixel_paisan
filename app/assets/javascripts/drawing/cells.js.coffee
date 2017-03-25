
$('#painting_application_panel').ready ->

  class window.Cell
    constructor: () ->
      @my_color = {r: 255, g: 255, b: 255, a: 0}

    paint: (new_color) ->
      old_color = @my_color
      @my_color = new_color
      if colors_equal(old_color, @my_color)
        return undefined
      else
        return old_color

    clear: () ->
      @my_color = {r: 255, g: 255, b: 255, a: 0}

    import: (color) ->
      @my_color = color

    get_color: ->
      return @my_color
