$ ->
  $('#painting_application_panel').ready ->

    window.undo_stack = []

    $('#undo_button').click () ->
      if undo_stack.length > 0
        undo_block = undo_stack.pop()
        for undo_action in undo_block
          undo_action.trigger()

    class window.UndoToken
      constructor: (@fill_style, @cell) ->

      trigger: ->
        @cell.undo(@fill_style)
