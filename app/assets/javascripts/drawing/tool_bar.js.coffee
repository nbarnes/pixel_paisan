$ ->
  $('#painting_application_panel').ready ->

    in_menu_mode = false

    $('.tool_bar_element').click ->
      entering_menu_mode = !in_menu_mode
      console.log("entering_menu_mode = #{entering_menu_mode}")
      if entering_menu_mode
        $(this).find('.dropdown_element').show()
      else
        $('.dropdown_element').hide()
      in_menu_mode = entering_menu_mode

    $('.tool_bar_element').mouseover ->
      $('.tool_bar_element').removeClass('selected')
      $(this).addClass('selected')
      if in_menu_mode
        $('.dropdown_element').hide()
        $(this).find('.dropdown_element').show()

    $('.tool_bar_element').mouseout ->
      unless in_menu_mode
        $('.tool_bar_element').removeClass('selected')

    $('.dropdown_menu_element').click ->
      $('.dropdown_element').hide()
