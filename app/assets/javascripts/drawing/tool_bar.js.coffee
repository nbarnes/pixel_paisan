$ ->
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
