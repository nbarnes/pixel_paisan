
$('#display_entry').ready ->

  window.picture_id = $('#display_entry').data('picture-id')

  $('#change_picture_name_button').click (e) ->
    new_picture_name = window.prompt('Enter a new name for your picture', '')
    new_picture_name = massage_picture_name new_picture_name
    if not new_picture_name
      new_picture_name = 'unnamed_picture'
    payload = {}
    payload.name = new_picture_name
    payload.picture_id = picture_id
    $.ajax "/pictures/#{picture_id}",
      type: 'PATCH',
      data: JSON.stringify(payload)
      dataType: 'json'
      contentType: 'application/json'
      success: (data, textStatus, jqXHR) ->
        $('#picture_name_display').html(new_picture_name)
        # console.log("returned data = #{JSON.stringify(data, undefined, 2)}")
        # console.log(textStatus)
        # console.log(jqXHR)
        # console.log(jqXHR.getAllResponseHeaders())
      error: (jqXHR, textStatus, errorThrown) ->
        # console.log("#{JSON.stringify(jqXHR, undefined, 2)}")
        # console.log("#{textStatus}")
        # console.log("#{errorThrown}")
        # console.log(jqXHR.getAllResponseHeaders())\
