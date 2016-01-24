$ ->
  $('#painting_application_panel').ready ->

    $('#save_picture_button').click () ->
      $("#picture_saved_modal").modal({overlayClose: false})
      $("#picture_saved_modal").text('Your picture is being saved.  This may take a few moments.')
      window.saving_picture_modal_timeout = setTimeout ( ->
        $("#picture_saved_modal").text('It is taking a long time to communicate with the Pixel Paisan server to save your picture. Your internet connection may have been interrupted. Click anywhere to close this window.')
        set_modal_closable()
        ), 300000
      payload = canvas_to_json()
      entered_picture_name = $('#picture_name_field').val()
      if entered_picture_name == '<enter picture name>'
        payload.name = ""
      else
        payload.name = entered_picture_name
      console.log("Packing payload for image transfer to server; picture_id = #{picture_id}")
      payload.cell_size = $('#cell_size_field').val()
      payload.picture_id = picture_id
      if picture_id == undefined
        console.log('POSTing picture')
        post_image(payload)
      else
        console.log('PATCHing picture')
        patch_image(payload)

    canvas_to_json = () ->
      image = {}
      image.pixel_data = []

      for x in [0...canvas_size_in_cells()]
        image.pixel_data.push( [] )
        for y in [0...canvas_size_in_cells()]
          cell = cells[x][y]
          image.pixel_data[x].push(cell.my_color)

      return image

    set_modal_closable = () ->
      $("#picture_saved_modal").addClass('simplemodal-close')
      $.modal.impl.o.overlayClose = true
      $.modal.impl.unbindEvents()
      $.modal.impl.bindEvents()

    # 'dataType' is NOT flagging the data being sent, but rather
    # flagging the expected data form response.  So, though we are
    # sending JSON, we are expecting an HTML response (either 200
    # ok or 500 internal_server_error otherwise empty headers)
    post_image = (payload) ->
      $.ajax "/pictures",
        type: 'POST'
        data: JSON.stringify(payload)
        dataType: 'json'
        contentType: 'application/json'
        error: (jqXHR, textStatus, errorThrown) ->
          $("#picture_saved_modal").text("An error occured while saving your picture: #{errorThrown}")
          set_modal_closable()
          clearTimeout(saving_picture_modal_timeout)
          console.log('AJAX posting of new image failure')
          console.log("#{JSON.stringify(jqXHR, undefined, 2)}")
          console.log("#{textStatus}")
          console.log("#{errorThrown}")
        success: (data, textStatus, jqXHR) ->
          $("#picture_saved_modal").text('Your picture has been successfully saved. Click anywhere to close this window.')
          set_modal_closable()
          clearTimeout(saving_picture_modal_timeout)
          console.log('AJAX posting of new image success')
          console.log("Data = #{JSON.stringify(data, undefined, 2)}")
          window.picture_id = data.picture_id

    patch_image = (payload) ->
      $.ajax "/pictures/#{payload.picture_id}",
        type: 'PATCH'
        data: JSON.stringify(payload)
        dataType: 'json'
        contentType: 'application/json'
        error: (jqXHR, textStatus, errorThrown) ->
          $("#picture_saved_modal").text("An error occured while saving your picture: #{errorThrown}")
          set_modal_closable()
          clearTimeout(saving_picture_modal_timeout)
          console.log('AJAX patching of existing image failure')
          console.log("#{JSON.stringify(jqXHR, undefined, 2)}")
          console.log("#{textStatus}")
          console.log("#{errorThrown}")
        success: (data, textStatus, jqXHR) ->
          $("#picture_saved_modal").text('Your picture has been successfully saved. Click anywhere to close this window.')
          set_modal_closable()
          clearTimeout(saving_picture_modal_timeout)
          console.log('AJAX patching of existing image success')
          console.log("Data = #{JSON.stringify(data, undefined, 2)}")
