$('#painting_application_panel').ready ->
  window.PackingTape = (->

    pack_for_picture = (picture) ->
      packed_picture = {}
      packed_picture.id = picture.get_picture_id()
      packed_picture.palette_id = picture.get_palette_id()
      packed_picture.pixels = pack_pixels(picture)
      packed_picture.cell_size = picture.get_cell_size()
      packed_picture.name = picture.get_name()
      return packed_picture

    pack_for_picture_name_change = (picture) ->
      packed_picture = {}
      packed_picture.id = picture.get_picture_id()
      packed_picture.name = picture.get_name()
      return packed_picture

    pack_for_palette_change = (picture) ->
      packed_picture = {}
      packed_picture.id = picture.get_picture_id()
      packed_picture.palette_id = picture.get_palette_id()
      return packed_picture

    pack_for_add_color_to_palette = (palette_id, r_val, g_val, b_val) ->
      return {
        palette_id: palette_id,
        r: r_val,
        g: g_val,
        b: b_val,
        a: 1
      }

    import_picture = (data) ->
      Picture.import_picture_data(data)

    pack_pixels = (picture) ->
      pixels = []
      for x in [0...picture.get_dimension()]
        pixels.push( [] )
        for y in [0...picture.get_dimension()]
          pixels[x].push(picture.get_cell(x, y).get_color())
      return pixels

    return {
      pack_for_picture_name_change: pack_for_picture_name_change
      pack_for_picture: pack_for_picture
      pack_for_palette_change: pack_for_palette_change
      pack_for_add_color_to_palette: pack_for_add_color_to_palette
      import_picture: import_picture
    }

  )()
