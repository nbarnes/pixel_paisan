describe "Picture", ->

  beforeEach ->
    MagicLamp.load('static_pages/editor')

  it "should change names", ->
    expect(Picture.get_name()).toBe('new_picture')
    Picture.set_name('test_name')
    expect(Picture.get_name()).toBe('test_name')

  it "should change dimensions", ->
    expect(Picture.get_dimension()).toBe(0)
    Picture.set_dimension(25)
    expect(Picture.get_dimension()).toBe(25)

  it "should change cell sizes", ->
    expect(Picture.get_cell_size()).toBe(0)
    Picture.set_cell_size(25)
    expect(Picture.get_cell_size()).toBe(25)
