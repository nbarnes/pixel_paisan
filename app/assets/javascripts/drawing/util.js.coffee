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

  window.pixel_paisan_ajax = ({data, url, verb, success_callback, error_callback}) ->
    $.ajax url,
      type: verb,
      data: JSON.stringify(data)
      dataType: 'json'
      contentType: 'application/json'
      # beforeSend: (req) ->
      #   req.setRequestHeader('Accept', 'application/json');
      success: (data, textStatus, jqXHR) ->
        console.log('pixel_paisan_ajax success callback execution')
        console.log("returned data = #{JSON.stringify(data, undefined, 2)}")
        # console.log(textStatus)
        # console.log(jqXHR)
        # console.log(jqXHR.getAllResponseHeaders())
        success_callback(data, textStatus, jqXHR)
      error: (jqXHR, textStatus, errorThrown) ->
        # console.log("#{JSON.stringify(jqXHR, undefined, 2)}")
        # console.log("#{textStatus}")
        # console.log("#{errorThrown}")
        # console.log(jqXHR.getAllResponseHeaders())
        error_callback(jqXHR, textStatus, errorThrown)
