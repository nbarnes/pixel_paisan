$ ->

  massage_picture_name = (raw_name) ->
    return raw_name.replace(/\ /g, '_').replace(/[^\w\s]/g, '')

  $('#display_entry').ready ->

    $('#change_picture_name_button').click (e) ->
      new_picture_name = window.prompt('Enter a new name for your picture', '')
      new_picture_name = massage_picture_name new_picture_name
      if not new_picture_name
        new_picture_name = 'unnamed_picture'
      payload = {}
      payload.picture_name = new_picture_name
      payload.picture_id = picture_id
      patch_picture_name(payload)

  $('#painting_application_panel').ready ->

    $('#save_picture_button').click () ->
      if a_user_is_logged_in()
        save_picture_to_server()
      else
        show_modal_pane('log_in_to_save_pane', true)

    $('#change_picture_name_button').click (e) ->
      new_picture_name = window.prompt('Enter a new name for your picture', '')
      new_picture_name = massage_picture_name new_picture_name
      if not new_picture_name
        new_picture_name = 'unnamed_picture'
      if picture_id == undefined
        $('#picture_name_display').html(new_picture_name)
      else
        payload = {}
        payload.picture_name = new_picture_name
        payload.picture_id = picture_id
        patch_picture_name(payload)

    save_picture_to_server = () ->
      show_modal_pane('picture_saving_pane', false)
      window.saving_picture_modal_timeout = setTimeout ( ->
        show_modal_pane('upload_timeout_pane', true)
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
      $(".modal_container").addClass('simplemodal-close')
      $.modal.impl.o.overlayClose = true
      $.modal.impl.unbindEvents()
      $.modal.impl.bindEvents()

    post_image = (payload) ->
      pixel_paisan_ajax(
        data: payload
        url: '/pictures'
        verb: 'POST'
        success_callback: (data, textStatus, jqXHR) ->
          # console.log('AJAX POSTing of new image success')
          show_modal_pane('picture_saved_pane', true)
          set_modal_closable()
          clearTimeout(saving_picture_modal_timeout)
          window.picture_id = data.picture_id
        error_callback: (jqXHR, textStatus, errorThrown) ->
          console.log('AJAX POSTing of new image failure')
          show_modal_pane('picture_upload_error_pane', true)
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
          show_modal_pane('picture_saved_pane', true)
          set_modal_closable()
          clearTimeout(saving_picture_modal_timeout)
        error_callback: (jqXHR, textStatus, errorThrown) ->
          console.log('AJAX PATCHing of existing image failure')
          show_modal_pane('picture_upload_error_pane', true)
          set_modal_closable()
          clearTimeout(saving_picture_modal_timeout)
      )

    a_user_is_logged_in = () ->
      return $('#painting_application_panel').data('user-id')

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

  patch_associated_palette = (payload) ->
    pixel_paisan_ajax(
      data: payload
      url: "/pictures/#{payload.picture_id}"
      verb: 'PATCH'
      success_callback: (data, textStatus, jqXHR) ->
        console.log('AJAX PATCHing of associated palette success')
      error_callback: (jqXHR, textStatus, errorThrown) ->
        console.log('AJAX PATCHing of associated palette error')
    )



