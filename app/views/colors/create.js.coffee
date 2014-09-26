
$('#color_form').html()
$('#color_form').hide()
$('#new_color_link').show()
$('#colors_index').append("<%= j render( @color ) %>")
