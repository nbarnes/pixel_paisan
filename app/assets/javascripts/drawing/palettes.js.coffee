
window.Palettes = (->

  palette_elements = {}

  palette_selector_changed = ->
    palette_id = $( '#palette_selector option:selected' ).val()
    Picture.set_palette_id(palette_id)
    show_palette(palette_id)

  show_palette = (palette_id) ->
    $('.palette').hide()
    palette_element = palette_elements[palette_id]
    if palette_element
      show_palette_element(palette_element, palette_id)
    else
      ColdStorage.get_palette(palette_id)

  show_palette_element = (palette_element, palette_id) ->
    palette_element.show()
    $("select#palette_selector option[value='#{palette_id}']").prop('selected', true)
    $('#color_picker_opener').visible(!palette_element.data('is-default-palette'))
    second_color_button = palette_element.find('.color_button')[1]
    if second_color_button?
      second_color_button.click()
    first_color_button = palette_element.find('.color_button')[0]
    if first_color_button?
      first_color_button.click()

  create_palette_element = (palette_data) ->
    palette_element = $('<div/>', { 'class':'palette' })
    for i in [0...palette_data.colors.length]
      color = palette_data.colors[i]
      add_color_button_to_palette_element(color, palette_element)
    palette_element.data('is-default-palette', palette_data['is_default_palette'])
    palette_element.appendTo($('#palette_wrapper'))
    palette_elements[palette_data.id] = palette_element
    return palette_element

  import_palette = (palette_data) ->
    create_palette_element(palette_data)
    show_palette(palette_data.id)

  add_color_button_to_palette = (color, palette_id) ->
    palette_element = palette_elements[palette_id]
    add_color_button_to_palette_element(color, palette_element)

  add_color_button_to_palette_element = (color, palette_element) ->
    color_button = $('<div/>', { 'class':'color_button' })
    color_button.attr('id', "color_button_r#{color.r}g#{color.g}b#{color.b}")
    color_button.css('background', "rgb(#{color.r},#{color.g},#{color.b})")
    color_button.bind 'click', get_click_handler(color)
    palette_element.append(color_button)

  add_new_color_to_palette = (r_val, g_val, b_val) ->
    palette_id = $( '#palette_selector option:selected' ).val()
    payload = PackingTape.pack_for_add_color_to_palette(palette_id, r_val, g_val, b_val)
    ColdStorage.add_new_color_to_palette(payload)

  get_click_handler = (color) ->
    ->
      ColorSelection.set_current_color(color)

  return {
    import_palette: import_palette
    palette_selector_changed: palette_selector_changed
    add_color_button_to_palette: add_color_button_to_palette
    add_new_color_to_palette: add_new_color_to_palette
    show_palette: show_palette
  }

)()
