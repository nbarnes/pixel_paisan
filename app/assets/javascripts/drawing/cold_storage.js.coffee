
window.ColdStorage = (->

  store_picture = (serialized_picture) ->
    show_modal_pane('picture_saving_pane', false)
    window.saving_picture_modal_timeout = setTimeout ( ->
      show_modal_pane('upload_timeout_pane', true)
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
        show_modal_pane('picture_saved_pane', true)
        set_modal_closable()
        clearTimeout(saving_picture_modal_timeout)
        Picture.set_picture_id(data.picture_id)
        Picture.set_name(data.picture_name)
      error_callback: (jqXHR, textStatus, errorThrown) ->
        console.log('AJAX transmission of image failure')
        show_modal_pane('picture_upload_error_pane', true)
        set_modal_closable()
        clearTimeout(saving_picture_modal_timeout)
    )

  get_picture = (picture_id) ->
    show_modal_pane('retrieving_picture_pane', false)
    do_ajax(
      url: "/pictures/#{picture_id}",
      verb: 'GET'
      success_callback: (data, textStatus, jqXHR) ->
        # console.log('AJAX get of picture data success')
        $.modal.close()
        PackingTape.import_picture(data)
      error_callback: (jqXHR, textStatus, errorThrown) ->
        show_modal_pane('picture_retrieval_failure_pane', true)
        set_modal_closeable()
        console.log('AJAX get of picture data failure')
    )

  add_new_color_to_palette = (payload) ->
    do_ajax
      url: "/palettes/#{payload.palette_id}/create_color",
      verb: 'POST'
      data: payload
      success_callback: (data, textStatus, jqXHR) ->
        Palettes.add_color_button_to_palette({ r: data.r, g: data.g, b: data.b, a: data.a }, payload.palette_id)
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

  do_ajax = ({data, url, verb, success_callback, error_callback}) ->
    $.ajax url,
      type: verb,
      data: JSON.stringify(data)
      dataType: 'json'
      contentType: 'application/json'
      # beforeSend: (req) ->
      #   req.setRequestHeader('Accept', 'application/json');
      success: (data, textStatus, jqXHR) ->
        # console.log('pixel_paisan_ajax success callback execution')
        # console.log("returned data = #{JSON.stringify(data, undefined, 2)}")
        # console.log(textStatus)
        # console.log(jqXHR)
        # console.log(jqXHR.getAllResponseHeaders())
        success_callback(data, textStatus, jqXHR)
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("#{JSON.stringify(jqXHR, undefined, 2)}")
        console.log("#{textStatus}")
        console.log("#{errorThrown}")
        console.log(jqXHR.getAllResponseHeaders())
        error_callback(jqXHR, textStatus, errorThrown)

  return {
    store_picture: store_picture
    get_picture: get_picture
    add_new_color_to_palette: add_new_color_to_palette
    get_palette: get_palette
  }

)()
