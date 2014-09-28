
$('#color_form').html()
$('#color_form').hide()
$('#new_color_link').show()
$('.colors_index').append("<%= j render( @color ) %>")
$('.colors_index').append("<%= j render 'palettes/delete_palette_color_link', palette_color: @palette_color %>")
