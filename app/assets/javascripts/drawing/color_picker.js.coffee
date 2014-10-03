$ ->

  $("#add_new_color_button").spectrum
    color: "#f00"
    change: (color) ->
      console.log( "change called: " + color.toHexString() )
      add_new_color_to_palette(color)


  new_color_added = (color) ->
    palette_id = $( '#palette_selector option:selected' ).val()
    payload = {
      palette_id: palette_id,
      r: color.r
      g: color.g
      b: color.b
      a: 1
    }

    $.post("/color_palette/", payload, (response) ->
      console.log "response received"
    , "json")