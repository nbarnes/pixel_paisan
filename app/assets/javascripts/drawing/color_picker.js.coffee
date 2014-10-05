$ ->

  $("#add_new_color_button").spectrum
    color: "#f00"
    change: (color) ->
      post_new_color_to_server(color)

  post_new_color_to_server = (color) ->
    palette_id = $( '#palette_selector option:selected' ).val()
    payload = {
      palette_id: palette_id,
      r: color.toRgb().r,
      g: color.toRgb().g,
      b: color.toRgb().b,
      a: 1
    }
    $.ajax "/colors",
      type: 'POST'
      data: payload
      dataType: 'JSON'
      error: (jqXHR, textStatus, errorThrown) ->
          console.log('AJAX posting of new color failure')
          console.log("#{JSON.stringify(jqXHR, undefined, 2)}")
          console.log("#{textStatus}")
          console.log("#{errorThrown}")
      success: (data, textStatus, jqXHR) ->
          console.log('AJAX posting of new color success')
          console.log("Data = #{JSON.stringify(data, undefined, 2)}")
          add_color_to_palette({ r: data.r, g: data.g, b: data.b, a: data.a })