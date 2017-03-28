$('#painting_application_panel').ready ->

  in_menu_mode = false

  $('body').click ->
    if in_menu_mode
      leave_menu_mode()

  $('.tool_bar_element').click ->
    entering_menu_mode = !in_menu_mode
    if entering_menu_mode
      $(this).find('.dropdown_element').removeClass('hidden')
      enter_menu_mode()
    else
      leave_menu_mode()
    return false

  $('.tool_bar_element').mouseover ->
    $('.tool_bar_element').removeClass('selected')
    $(this).addClass('selected')
    if in_menu_mode
      $('.dropdown_element').addClass('hidden')
      $(this).find('.dropdown_element').removeClass('hidden')

  $('.tool_bar_element').mouseout ->
    unless in_menu_mode
      $('.tool_bar_element').removeClass('selected')

  enter_menu_mode = ->
    in_menu_mode = true

  leave_menu_mode = ->
    in_menu_mode = false
    $('.dropdown_element').addClass('hidden')

  $('#new_picture_option').click ->
    Picture.new_picture()
    Painter.paint_canvas(Picture)
    history.pushState(null, null, '/editor')

  $('#save_picture_option').click ->
    if a_user_is_logged_in()
      ColdStorage.store_picture(PackingTape.pack_for_picture(Picture))
    else
      show_modal_pane('log_in_to_save_pane', true)

  $('#rename_picture_option').click ->
    new_picture_name = window.prompt('Enter a new name for your picture', '')
    new_picture_name = massage_picture_name new_picture_name
    Picture.set_name(new_picture_name)
