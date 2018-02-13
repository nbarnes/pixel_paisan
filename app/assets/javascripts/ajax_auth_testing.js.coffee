$ ->
  $('#ajax_auth_testing_panel').ready ->

    $('#login_submit_button').click (e) ->
      console.log('login_submit_button')
      email = $('#login_email_field').val();
      password = $('#login_password_field').val();
      do_ajax(
        data: {"email": email, "password": password},
        url: "/users/sign_in",
        verb: 'POST'
        success_callback: (data, textStatus, jqXHR) ->
          console.log('AJAX login success')
        error_callback: (jqXHR, textStatus, errorThrown) ->
          console.log('AJAX login failure')
      )


    $('#signup_submit_button').click (e) ->
      console.log('signup_submit_button')
      # do_ajax(
      #   url: "/pictures/#{picture_id}",
      #   verb: 'GET'
      #   success_callback: (data, textStatus, jqXHR) ->
      #     # console.log('AJAX get of picture data success')
      #     $.modal.close()
      #     PackingTape.import_picture(data)
      #   error_callback: (jqXHR, textStatus, errorThrown) ->
      #     show_modal_pane('picture_retrieval_failure_pane', true)
      #     set_modal_closeable()
      #     console.log('AJAX get of picture data failure'
      # )
