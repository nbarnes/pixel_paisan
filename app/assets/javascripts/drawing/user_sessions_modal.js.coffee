$ ->
  $('#new_user_save_modal').ready ->

    $("#modal_user_login_test_button").click () ->
      console.log('bob')
      $("#new_user_save_modal").modal({overlayClose: true})

    $('#trigger_ajax_login_button').click () ->
      $.ajax "/accounts/sign_in",
        data: get_test_login_payload()
        type: 'POST'
        dataType: 'json'
        error: (jqXHR, textStatus, errorThrown) ->
          console.log('AJAX post of login data failure')
          console.log("#{JSON.stringify(jqXHR, undefined, 2)}")
          console.log("#{textStatus}")
          console.log("#{errorThrown}")
        success: (data, textStatus, jqXHR) ->
          console.log('AJAX post of login data success')
          console.log(data)
          $.modal.close()

    get_test_login_payload = ->
      return { user: {
        email: 'galactus@everywhere.com',
        password: 'password',
        remember_me: 1,
        commit: 'Log in'
      } }