$ ->
  $('#painting_application_panel').ready ->

    $('#upload_button').click () ->
      payload = canvas_to_json()
      entered_picture_name = $('#picture_name_field').val()
      if entered_picture_name == '<enter picture name>'
        payload.name = ""
      else
        payload.name = entered_picture_name
      console.log("Packing payload for image transfer to server; picture_id = #{picture_id}")
      payload.picture_id = picture_id
      payload.cell_size = $('#cell_size_field').val()
      post_image(payload)

    canvas_to_json = () ->
      image = {}
      image.image_data = []

      for x in [0...canvas_size_in_cells()]
        image.image_data.push( [] )
        for y in [0...canvas_size_in_cells()]
          cell = cells[x][y]
          image.image_data[x].push(cell.my_color)

      return image

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
          window.picture_id = data.picture_id
