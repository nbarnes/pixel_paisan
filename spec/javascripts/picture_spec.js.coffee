describe "Picture", ->

  beforeEach ->
    MagicLamp.load('static_pages/editor')

  it "should change names", ->
    Picture.set_name('test_name')
    expect(Picture.get_name()).toBe('test_name')

  it "should change dimensions", ->
    Picture.set_dimension(11)
    expect(Picture.get_dimension()).toBe(11)

  it "should change cell sizes", ->
    Picture.set_cell_size(7)
    expect(Picture.get_cell_size()).toBe(7)

  it "should change palette id", ->
    Picture.set_palette_id(25)
    expect(Picture.get_palette_id()).toBe(25)
