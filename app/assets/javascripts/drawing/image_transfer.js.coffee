$ ->

  $('#upload_button').click () ->
    payload = canvas_to_json()
    # image_name = prompt("Please enter a name for the image")
    entered_picture_name = $('#picture_name_field').val()
    if entered_picture_name == '<enter picture name>'
      payload.name = ""
    else payload.name = entered_picture_name
    if payload.image_name != null
      post_image(payload)
    # console.log "canvas_to_json called"

  canvas_to_json = () ->
    image = {}
    image.image_data = []

    for x in [0...canvas_size_in_cells()]
      image.image_data.push( [] )
      for y in [0...canvas_size_in_cells()]
        cell = cells[x][y]
        image.image_data[x].push(cell.my_color)

    return image

  canvas_to_rgba_string = () ->
    string = ""

    for x in [0...canvas_size_in_cells()]
      for y in [0...canvas_size_in_cells()]
        c = cells[x][y].my_color
        string = string + "#{c.r}#{c.g}#{c.b}#{c.a}"

    return string

  # 'dataType' is NOT flagging the data being sent, but rather
  # flagging the expected data form response.  So, though we are
  # sending JSON, we are expecting an HTML response (either 200
  # ok or 500 internal_server_error otherwise empty headers)
  post_image = (payload) ->
    $.ajax "/snapshots",
      type: 'POST'
      data: JSON.stringify(payload)
      dataType: 'json'
      contentType: 'application/json'
      error: (jqXHR, textStatus, errorThrown) ->
          console.log('AJAX posting of new image failure')
          console.log("#{JSON.stringify(jqXHR, undefined, 2)}")
          console.log("#{textStatus}")
          console.log("#{errorThrown}")
      success: (data, textStatus, jqXHR) ->
          console.log('AJAX posting of new image success')
          console.log("Data = #{JSON.stringify(data, undefined, 2)}")
