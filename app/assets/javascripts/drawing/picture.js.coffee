$('#painting_application_panel').ready ->
  window.Picture = (->

    cells = [[]]
    palette_id = undefined
    picture_id = undefined
    name = 'new_picture'
    dimension = 15
    cell_size = 24

    resize_cell_matrix = (dimension) ->
      for x in [0...dimension]
        unless cells[x]?
          cells[x] = new Array
        for y in [0...dimension]
          unless cells[x][y]?
            cells[x][y] = new Cell(x, y)

    get_cell = (x, y) ->
      if x < dimension and y < dimension
        return cells[x][y]
      else
        return undefined

    get_dimension = ->
      return dimension

    set_dimension = (new_dimension) ->
      dimension = new_dimension
      resize_cell_matrix(dimension)
      Canvas.resize_canvas_element()

    get_cell_size = ->
      return cell_size

    set_cell_size = (new_cell_size) ->
      cell_size = new_cell_size
      Canvas.resize_canvas_element()

    get_palette_id = ->
      return palette_id

    set_palette_id = (new_palette_id) ->
      if (palette_id != new_palette_id) && picture_id # only try to update the associated palette if the picture is already persisted
        ColdStorage.store_picture(PackingTape.pack_for_picture_pallete_update(this))
      palette_id = new_palette_id

    get_picture_id = ->
      return picture_id

    set_picture_id = (new_picture_id) ->
      picture_id = new_picture_id

    get_name = ->
      return name

    set_name = (new_name) ->
      if name != new_name
        ColdStorage.store_picture(PackingTape.pack_for_picture_name_update(this))
      name = new_name

    new_picture = ->
      clear()
      picture_id = undefined
      name = 'new_picture'

    clear = ->
      for x in [0...cells.length]
        for y in [0...cells.length]
          cells[x][y].clear()

    import_picture_data = (picture_data) ->
      set_cell_size(data.cell_size)
      set_dimension(data.image_data.length)
      name = data.picture_name
      picture_id = data.picture_id
      palette_id = data.palette_id
      for x in [0...dimension]
        for y in [0...dimension]
          r = image_data[x][y].r
          g = image_data[x][y].g
          b = image_data[x][y].b
          a = image_data[x][y].a
          cells[x][y].import({r: r, g: g, b: b, a: a})
      paint_canvas()

    return {
      get_cell: get_cell
      get_dimension: get_dimension
      set_dimension: set_dimension
      get_cell_size: get_cell_size
      set_cell_size: set_cell_size
      get_palette_id: get_palette_id
      set_palette_id: set_palette_id
      get_picture_id: get_picture_id
      set_picture_id: set_picture_id
      get_name: get_name
      set_name: set_name
      new_picture: new_picture
      clear: clear
      import_picture_data: import_picture_data
    }

  )()
