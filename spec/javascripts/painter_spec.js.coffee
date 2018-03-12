describe "Picture", ->

  beforeEach ->
    MagicLamp.load('static_pages/editor')

  it "should change the color of cells", ->
    cell_size = 4
    new_color = {r: 122, g: 144, b: 166, a: 1}

    Picture.set_dimension(4) # make sure that the picture is the appropriate size for our test
    Picture.set_cell_size(cell_size) # make sure that the picture is the appropriate size for our test

    ColorSelection.set_current_color(new_color)

    # make sure we're clicking on the right cell
    Painter.paint_cell(((2 * cell_size) - 2), ((2 * cell_size) - 2))

    expect(Picture.get_cell(1, 1).get_color()).toBe(new_color)
