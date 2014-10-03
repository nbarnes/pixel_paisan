$ ->

  $("#add_new_color_button").spectrum
    color: "#f00"
    change: (color) ->
      add_new_color_to_palette(color)


  add_new_color_to_palette = (color) ->
    palette_id = $( '#palette_selector option:selected' ).val()
    payload = {
      palette_id: palette_id,
      r: color.toRgb().r,
      g: color.toRgb().g,
      b: color.toRgb().b,
      a: 1
    }
    console.log("new color added, json payload is #{JSON.stringify(payload,null,2)}")
    $.ajax "/colors",
      type: 'POST'
      dataType: 'JSON'
      error: (jqXHR, textStatus, errorThrown) ->
          console.log('AJAX posting of new color failure')
          console.log("#{jqXHR}")
          console.log("#{textStatus}")
          console.log("#{errorThrown}")
      success: (data, textStatus, jqXHR) ->
          console.log('AJAX posting of new color success')