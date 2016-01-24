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
      # console.log("Packing payload for image transfer to server; picture_id = #{picture_id}")
      payload.cell_size = $('#cell_size_field').val()
      payload.picture_id = picture_id
      if picture_id == undefined
        # console.log('POSTing picture')
        post_image(payload)
      else
        # console.log('PATCHing picture')
        patch_image(payload)

    $('#change_picture_name_button').click (e) ->
      new_picture_name = window.prompt('Enter a new name for your picture', '').replace(/[^a-zA-Z0-9_]/gi, '')
      if not new_picture_name
        new_picture_name = 'unnamed_picture'
      if picture_id == undefined
        $('#picture_name_display').html(new_picture_name)
      else
        payload = {}
        payload.picture_name = new_picture_name
        payload.picture_id = picture_id
        patch_picture_name( payload )

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
      pixel_paisan_ajax(
        data: payload
        url: '/pictures'
        verb: 'POST'
        success_callback: (data, textStatus, jqXHR) ->
          console.log('AJAX POSTing of new image success')
          $("#picture_saved_modal").text('Your picture has been successfully saved. Click anywhere to close this window.')
          set_modal_closable()
          clearTimeout(saving_picture_modal_timeout)
          window.picture_id = data.picture_id
        error_callback: (jqXHR, textStatus, errorThrown) ->
          console.log('AJAX POSTing of new image failure')
          $("#picture_saved_modal").text("An error occured while saving your picture: #{errorThrown}")
          set_modal_closable()
          clearTimeout(saving_picture_modal_timeout)
      )

    patch_image = (payload) ->
      pixel_paisan_ajax(
        data: payload
        url: "/pictures/#{payload.picture_id}"
        verb: 'PATCH'
        success_callback: (data, textStatus, jqXHR) ->
          console.log('AJAX PATCHing of existing image success')
          $("#picture_saved_modal").text('Your picture has been successfully saved. Click anywhere to close this window.')
          set_modal_closable()
          clearTimeout(saving_picture_modal_timeout)
        error_callback: (jqXHR, textStatus, errorThrown) ->
          console.log('AJAX PATCHing of existing image failure')
          $("#picture_saved_modal").text("An error occured while saving your picture: #{errorThrown}")
          set_modal_closable()
          clearTimeout(saving_picture_modal_timeout)
      )

    patch_picture_name = (payload) ->
      pixel_paisan_ajax(
        data: payload
        url: "/pictures/#{payload.picture_id}"
        verb: 'PATCH'
        success_callback: (data, textStatus, jqXHR) ->
          console.log('AJAX PATCHing of picture name success')
          $('#picture_name_display').html(data.picture_name)
        error_callback: (jqXHR, textStatus, errorThrown) ->
          console.log('AJAX PATCHing of picture name error')
      )



