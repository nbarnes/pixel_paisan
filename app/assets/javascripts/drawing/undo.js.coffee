$ ->
  $('#painting_application_panel').ready ->

    class window.UndoToken
      constructor: (@color, @x, @y) ->

      trigger: ->
        Painter.undo(@color, @x, @y)
