$ ->

  window.pretty_print = (obj) ->
    return JSON.stringify(obj, undefined, 2)

  (($) ->
    $.fn.visible = (to_show) ->
      # console.log("to_show = #{to_show}")
      # console.log(this)
      if to_show == true
        this.show()
      else if to_show == false
        this.hide()
      return
    ) jQuery

  window.show_modal = (id_to_show, closeable) ->
    $('#editor_modal_container').modal({overlayClose: closeable, focus: false})
    $('.modal_content_pane').hide()
    $('#' + id_to_show).show()

  window.set_modal_closable = () ->
    $(".modal_container").addClass('simplemodal-close')
    $.modal.impl.o.overlayClose = true
    $.modal.impl.unbindEvents()
    $.modal.impl.bindEvents()

  window.colors_equal = (foo, bar) ->
    if foo.r == bar.r
      if foo.g == bar.g
        if foo.b == bar.b
          if foo.a == bar.a
            return true
    return false

  window.massage_picture_name = (raw_name) ->
    return raw_name.replace(/\ /g, '_').replace(/[^\w\s]/g, '')

  window.massage_to_number = (raw_string) ->
    if raw_string == undefined || raw_string == null
      return 0
    return raw_string.replace(/\D/g, '')

  window.a_user_is_logged_in = ->
    return $('#painting_application_panel').data('user-id')

  window.do_ajax = ({data, url, verb, success_callback, error_callback}) ->
    fetch(url, {
      body: JSON.stringify(data)
      method: verb
      headers: {
        "content-type": "application/json"
        "accept": "application/json"
        "X-CSRF-Token": $('meta[name="csrf-token"]').attr('content')
      }
      credentials: 'same-origin'
    })
    .then( (response) ->
      return response.json()
    ).then( (json) ->
      success_callback(json)
    )
