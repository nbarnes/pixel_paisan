$ ->
  $('#painting_application_panel').ready ->

    $("#color_picker_opener").click () ->
      $("#color_picker_modal").modal({overlayClose: true})

    $(".color_value_field").change () ->
      new_r = $('#r_value_field').val()
      new_g = $('#g_value_field').val()
      new_b = $('#b_value_field').val()
      new_color = "rgb(#{new_r}, #{new_g}, #{new_b})"
      console.log(new_color)
      $("#color_display_panel").css('background-color', new_color)


    $("#add_new_color_button").click () ->
      $.modal.close()

    post_new_color_to_server = (color) ->
      palette_id = $( '#palette_selector option:selected' ).val()
      payload = {
        palette_id: palette_id,
        r: color.toRgb().r,
        g: color.toRgb().g,
        b: color.toRgb().b,
        a: 1
      }
      $.ajax "/colors",
        type: 'POST'
        data: payload
        dataType: 'JSON'
        success: (data, textStatus, jqXHR) ->
          console.log('AJAX posting of new color success')
          console.log("Data = #{JSON.stringify(data, undefined, 2)}")
          add_color_to_palette({ r: data.r, g: data.g, b: data.b, a: data.a })
        error: (jqXHR, textStatus, errorThrown) ->
          console.log('AJAX posting of new color failure')
          console.log("#{JSON.stringify(jqXHR, undefined, 2)}")
          console.log("#{textStatus}")
          console.log("#{errorThrown}")
