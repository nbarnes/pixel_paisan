
window.ColdStorage = (->

  store_picture = (serialized_picture) ->
    show_modal('awaiting_picture_save_modal')
    window.saving_picture_modal_timeout = setTimeout ( ->
      show_modal('picture_save_timeout_modal', true)
      set_modal_closable()
      ), 300000
    if serialized_picture.id == undefined
      verb = 'POST'
      url = '/pictures'
    else
      verb = 'PATCH'
      url = "/pictures/#{serialized_picture.id}"
    do_ajax(
      data: serialized_picture
      url: url
      verb: verb
      success_callback: (data, textStatus, jqXHR) ->
        # console.log('AJAX transmission of image success')
        show_modal('picture_save_success_modal', true)
        set_modal_closable()
        clearTimeout(saving_picture_modal_timeout)
        Picture.set_picture_id(data.picture_id)
        Picture.set_name(data.picture_name)
      error_callback: (jqXHR, textStatus, errorThrown) ->
        console.log('AJAX transmission of image failure')
        show_modal('picture_save_server_error_modal', true)
        set_modal_closable()
        clearTimeout(saving_picture_modal_timeout)
    )

  get_picture = (picture_id) ->
    show_modal('awaiting_picture_load_modal')
    do_ajax(
      url: "/pictures/#{picture_id}",
      verb: 'GET'
      success_callback: (data, textStatus, jqXHR) ->
        # console.log('AJAX get of picture data success')
        $.modal.close()
        PackingTape.import_picture(data)
      error_callback: (jqXHR, textStatus, errorThrown) ->
        show_modal('picture_load_server_error_modal', true)
        set_modal_closeable()
        console.log('AJAX get of picture data failure')
    )

  add_new_color_to_palette = (payload) ->
    do_ajax
      url: "/palettes/#{payload.palette_id}/create_color",
      verb: 'POST'
      data: payload
      success_callback: (data, textStatus, jqXHR) ->
        Palettes.add_color_button_to_palette({
                                               r: data.r,
                                               g: data.g,
                                               b: data.b,
                                               a: data.a
                                             },
                                             payload.palette_id
                                            )
      error_callback: (jqXHR, textStatus, errorThrown) ->
        console.log('AJAX posting of new color failure')

  get_palette = (palette_id) ->
    do_ajax
      url: "/palettes/#{palette_id}",
      verb: 'GET'
      data: {}
      success_callback: (data, textStatus, jqXHR) ->
        Palettes.import_palette(data)
      error_callback: (jqXHR, textStatus, errorThrown) ->
        console.log('AJAX retrival of palette failure')

  set_modal_closable = () ->
    $(".modal_container").addClass('simplemodal-close')
    $.modal.impl.o.overlayClose = true
    $.modal.impl.unbindEvents()
    $.modal.impl.bindEvents()

  return {
    store_picture: store_picture
    get_picture: get_picture
    add_new_color_to_palette: add_new_color_to_palette
    get_palette: get_palette
  }

)()
