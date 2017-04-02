
window.Picture = (->

  cells = []
  palette_id = undefined
  picture_id = undefined
  name = 'new_picture'
  dimension = 0
  cell_size = 0

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

  get_dimension = ->
    return dimension

  set_dimension = (new_dimension) ->
    dimension = new_dimension
    resize_cell_matrix(dimension)
    Canvas.resize_canvas_element(dimension, cell_size)

  get_cell_size = ->
    return cell_size

  set_cell_size = (new_cell_size) ->
    cell_size = new_cell_size
    Canvas.resize_canvas_element(dimension, cell_size)

  get_palette_id = ->
    return palette_id

  set_palette_id = (new_palette_id) ->
    palette_id = new_palette_id

  get_picture_id = ->
    return picture_id

  set_picture_id = (new_picture_id) ->
    picture_id = new_picture_id

  get_name = ->
    return name

  set_name = (new_name) ->
    # if name != new_name
    #   ColdStorage.store_picture(PackingTape.pack_for_picture_name_change(this))
    name = new_name
    $('#tool_bar_file_element .tool_bar_title').html("#{name} &#x25bc")

  new_picture = ->
    clear()
    picture_id = undefined
    set_name('new_picture')
    Painter.paint_canvas(this)

  clear = ->
    for x in [0...cells.length]
      for y in [0...cells.length]
        cells[x][y].clear()

  import_picture_data = (data) ->
    set_cell_size(data.cell_size)
    set_dimension(data.image_data.length)
    set_name(data.picture_name)
    palette_id = data.palette_id
    picture_id = data.picture_id
    for x in [0...dimension]
      for y in [0...dimension]
        r = data.image_data[x][y].r
        g = data.image_data[x][y].g
        b = data.image_data[x][y].b
        a = data.image_data[x][y].a
        cells[x][y].import({r: r, g: g, b: b, a: a})
    Painter.paint_canvas(this)
    Palettes.show_palette(palette_id)

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
