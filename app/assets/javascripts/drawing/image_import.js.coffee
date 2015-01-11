$ ->
  $('#painting_application_panel').ready ->

    window.import_image = (data) ->
      $('#cell_size_field').val(data.cell_size)
      $('#canvas_size_in_cells_field').val(get_dimension(data.image_data))
      resize_canvas_element()
      $('#picture_name_field').val(data.name)
      # console.log("image_data picture_id = #{data.picture_id}")
      picture_id = data.picture_id
      import_image_data(data.image_data)

    get_dimension = (image) ->
      return image.length

    import_image_data = (image) ->
      for x in [0...canvas_size_in_cells()]
        for y in [0...canvas_size_in_cells()]
            r = image[x][y].r
            g = image[x][y].g
            b = image[x][y].b
            a = image[x][y].a
            cells[x][y].import({r: r, g: g, b: b, a: a})

    # 'dataType' is NOT flagging the data being sent, but rather
    # flagging the expected data form response.
    window.retrieve_picture_from_server = (picture_id) ->
      $.ajax "/pictures/#{picture_id}",
        type: 'GET'
        dataType: 'json'
        error: (jqXHR, textStatus, errorThrown) ->
            console.log('AJAX get of snapshot data failure')
            console.log("#{JSON.stringify(jqXHR, undefined, 2)}")
            console.log("#{textStatus}")
            console.log("#{errorThrown}")
        success: (data, textStatus, jqXHR) ->
            console.log('AJAX get of snapshot data success')
            import_image(data)

  $('.pictures.edit').ready ->
    retrieve_picture_from_server($('#editor_pane').data('picture-id'))