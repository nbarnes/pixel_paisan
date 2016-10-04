 $ ->
  $('#painting_application_panel').ready ->

    $('#save_picture_button').click () ->
      if a_user_is_logged_in()
        save_picture_to_server()
      else
        $('#editor_modal_container').modal({overlayClose: true})
        show_modal_pane('log_in_to_save_pane')

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

    save_picture_to_server = () ->
        $("#editor_modal_container").modal({overlayClose: false})
        show_modal_pane('picture_saving_pane')
        window.saving_picture_modal_timeout = setTimeout ( ->
          show_modal_pane('upload_timeout_pane')
          set_modal_closable()
          ), 300000
        payload = canvas_to_json()
        payload.name = $('#picture_name_display').html()
        # console.log("Packing payload for image transfer to server; picture_id = #{picture_id}")
        payload.cell_size = $('#cell_size_field').val()
        payload.picture_id = picture_id
        if picture_id == undefined
          # console.log('POSTing picture')
          post_image(payload)
        else
          # console.log('PATCHing picture')
          patch_image(payload)

    canvas_to_json = () ->
      image = {}
      image.pixels = []

      for x in [0...canvas_size_in_cells()]
        image.pixels.push( [] )
        for y in [0...canvas_size_in_cells()]
          cell = cells[x][y]
          image.pixels[x].push(cell.my_color)

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
          show_modal_pane('picture_saved_pane')
          set_modal_closable()
          clearTimeout(saving_picture_modal_timeout)
          window.picture_id = data.picture_id
        error_callback: (jqXHR, textStatus, errorThrown) ->
          console.log('AJAX POSTing of new image failure')
          show_modal_pane('picture_upload_error_pane')
          set_modal_closable()
          clearTimeout(saving_picture_modal_timeout)
      )

    patch_image = (payload) ->
      pixel_paisan_ajax(
        data: payload
        url: "/pictures/#{payload.picture_id}"
        verb: 'PATCH'
        success_callback: (data, textStatus, jqXHR) ->
          # console.log('AJAX PATCHing of existing image success')
          show_modal_pane('picture_saved_pane')
          set_modal_closable()
          clearTimeout(saving_picture_modal_timeout)
        error_callback: (jqXHR, textStatus, errorThrown) ->
          console.log('AJAX PATCHing of existing image failure')
          show_modal_pane('picture_upload_error_pane')
          set_modal_closable()
          clearTimeout(saving_picture_modal_timeout)
      )

    patch_picture_name = (payload) ->
      pixel_paisan_ajax(
        data: payload
        url: "/pictures/#{payload.picture_id}"
        verb: 'PATCH'
        success_callback: (data, textStatus, jqXHR) ->
          # console.log('AJAX PATCHing of picture name success')
          $('#picture_name_display').html(data.picture_name)
        error_callback: (jqXHR, textStatus, errorThrown) ->
          console.log('AJAX PATCHing of picture name error')
      )

    a_user_is_logged_in = () ->
      return $('#painting_application_panel').data('user-logged-in')

    show_modal_pane = (id_to_show) ->
      $('.modal_content_pane').hide()
      $('#' + id_to_show).show()


