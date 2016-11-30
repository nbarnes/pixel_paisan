window.ColorSelection = (->

  current_color = {r: 0, g: 0, b: 0, a: 1}
  previous_color = {r: 0, g: 0, b: 0, a: 1}

  get_current_color = ->
    current_color
  get_previous_color = ->
    previous_color

  set_current_color = (new_color) ->
    set_previous_color(current_color)
    current_color = new_color
    pp_context.fillStyle = "rgba(#{new_color.r}, #{new_color.g}, #{new_color.b}, #{new_color.a})"
    $('#current_color_pane').css('background', "rgb(#{new_color.r},#{new_color.g},#{new_color.b})")

  set_previous_color = (new_color) ->
    previous_color = new_color
    $('#previous_color_pane').css('background',
                                  "rgb(#{previous_color.r},#{previous_color.g},#{previous_color.b})")

  return {
    get_current_color: get_current_color
    get_previous_color: get_previous_color
    set_current_color: set_current_color
    set_previous_color: set_previous_color
  }

)()
