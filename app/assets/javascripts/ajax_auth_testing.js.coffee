$ ->
  $('#ajax_auth_testing_panel').ready ->

    $('#login_submit_button').click (e) ->
      console.log('login_submit_button')
      email = $('#login_email_field').val()
      password = $('#login_password_field').val()
      do_ajax(
        data: {"email": email, "password": password},
        url: "/users/sign_in",
        verb: 'POST'
        success_callback: (data, textStatus, jqXHR) ->
          console.log('AJAX login success')
        error_callback: (jqXHR, textStatus, errorThrown) ->
          console.log('AJAX login failure')
      )
      e.preventDefault()


    $('#signup_submit_button').click (e) ->
      console.log('signup_submit_button')
      name = $('#signup_name_field').val()
      email = $('#signup_email_field').val()
      password = $('#signup_password_field').val()
      password_confirmation = $('#signup_password_field').val()
      do_ajax(
        data: {
          user: {
            "name": name,
            "email": email,
            "password": password,
            "password_confirmation": password_confirmation
          }
        },
        url: "/users",
        verb: 'POST'
        success_callback: (data, textStatus, jqXHR) ->
          console.log('AJAX login success')
        error_callback: (jqXHR, textStatus, errorThrown) ->
          console.log('AJAX login failure')
      )
      e.preventDefault()
