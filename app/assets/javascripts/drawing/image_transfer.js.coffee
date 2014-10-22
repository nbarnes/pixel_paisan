$ ->

  $('#upload_button').click () ->
    payload = canvas_to_json()
    # file_name = prompt("Please enter a name for the image")
    payload.file_name = 'the_image.png'
    if payload.file_name != null
      post_image(payload)
    console.log "canvas_to_json called"

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
    $.ajax "/images",
      type: 'POST'
      data: payload
      dataType: 'HTML'
      error: (jqXHR, textStatus, errorThrown) ->
          console.log('AJAX posting of new image failure')
          console.log("#{JSON.stringify(jqXHR, undefined, 2)}")
          console.log("#{textStatus}")
          console.log("#{errorThrown}")
      success: (data, textStatus, jqXHR) ->
          console.log('AJAX posting of new image success')
          console.log("Data = #{JSON.stringify(data, undefined, 2)}")
