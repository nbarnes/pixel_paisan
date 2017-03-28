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

  window.show_modal_pane = (id_to_show, closeable) ->
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

  # window.fillStyle_into_color = (fillStyle) ->
  #   color = {}
  #   if fillStyle.charAt(0) == "#"
  #     hex = fillStyle.slice(1)
  #     bigint = parseInt(hex, 16)
  #     color.r = (bigint & 0xff0000) >> 16
  #     color.g = (bigint & 0x00ff00) >> 8
  #     color.b = bigint & 0x0000ff
  #     color.a = 1
  #   else if fillStyle.charAt(0) == "r"
  #     rgb_string = fillStyle.split(")")
  #     rgb_string = rgb_string[0].split("(")
  #     rgb_string = rgb_string[1].split(",")
  #     color.r = parseInt(rgb_string[0])
  #     color.g = parseInt(rgb_string[1])
  #     color.b = parseInt(rgb_string[2])
  #     color.a = parseFloat(rgb_string[3])
  #   return color

  window.massage_picture_name = (raw_name) ->
    return raw_name.replace(/\ /g, '_').replace(/[^\w\s]/g, '')

  window.a_user_is_logged_in = ->
    return $('#painting_application_panel').data('user-id')
