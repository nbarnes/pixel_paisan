
$alert('add_color.js.coffee')
$('#color_form').html("<%= j (render '_add_color_form') %>")
$('#color_form').show()
$('#new_color_link').hide()
