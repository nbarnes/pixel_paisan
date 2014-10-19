$ ->

  window.undo_stack = []

  $('#undo_button').click () ->
    if undo_stack.length > 0
      undo_block = undo_stack.pop()
      console.log("undo button clicked, undo_stack is #{undo_stack.length}")
      console.log("undo button clicked, undo_block is #{undo_block.length}")

      for undo_action in undo_block
        undo_action.trigger()
    else
      console.log('undo_stack length 0, nothing to undo')

  class window.UndoToken
    constructor: (@fill_style, @cell) ->

    trigger: ->
      @cell.undo(@fill_style)


