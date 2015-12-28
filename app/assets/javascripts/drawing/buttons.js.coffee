$ ->
  $('#painting_application_panel').ready ->

    $('#canvas_clear_button').click (e) ->
      reset_drawing()

    $('#create_new_button').click (e) ->
      window.picture_id = undefined
      reset_drawing()

    $('#change_name_button').click () ->
      new_name = prompt("Enter the new name for this picture", $('#picture_name_field').val())
      $('#picture_name_display').text(new_name)
      # if picture_id == undefined
      #   return
      # post_name_change( {new_name: new_name} )

    # 'dataType' is NOT flagging the data being sent, but rather
    # flagging the expected data form response.  So, though we are
    # sending JSON, we are expecting an HTML response (either 200
    # ok or 500 internal_server_error otherwise empty headers)

    # post_name_change = (payload) ->
    #   $.ajax "/picture/3/change_name",
    #     type: 'POST'
    #     data: JSON.stringify(payload)
    #     dataType: 'json'
    #     contentType: 'application/json'
    #     error: (jqXHR, textStatus, errorThrown) ->
    #       $("#picture_saved_modal").text("An error occured while saving your name change: #{errorThrown}")
    #       # set_modal_closable()
    #       # clearTimeout(saving_picture_modal_timeout)
    #       # console.log('AJAX posting of new image failure')
    #       # console.log("#{JSON.stringify(jqXHR, undefined, 2)}")
    #       # console.log("#{textStatus}")
    #       # console.log("#{errorThrown}")
    #     success: (data, textStatus, jqXHR) ->
    #       $("#picture_saved_modal").text("Your picture's name has been changed. Click anywhere to close this window.")
    #       # set_modal_closable()
    #       # clearTimeout(saving_picture_modal_timeout)
    #       # console.log('AJAX posting of new image success')
    #       # console.log("Data = #{JSON.stringify(data, undefined, 2)}")
    #       # window.picture_id = data.picture_id
