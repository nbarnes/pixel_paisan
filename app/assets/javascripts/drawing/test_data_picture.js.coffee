$ ->
  $('#painting_application_panel').ready ->

    test_data_picture =
      name: 'test_picture_01'
      picture_id: 42
      cell_size: 50
      image: [ [
        { r:   0, g: 255, b: 255, a: 1 }
        { r: 255, g: 255, b: 255, a: 1 }
        { r:   0, g:   0, b: 255, a: 1 }
        { r: 255, g:   0, b: 255, a: 1 }
      ], [
        { r: 128, g: 128, b: 128, a: 1 }
        { r:   0, g: 128, b:   0, a: 1 }
        { r:   0, g: 255, b:   0, a: 1 }
        { r: 128, g:   0, b:   0, a: 1 }
      ], [
        { r:   0, g:   0, b: 128, a: 1 }
        { r: 128, g: 128, b:   0, a: 1 }
        { r: 255, g: 165, b:   0, a: 1 }
        { r: 128, g:   0, b: 128, a: 1 }
      ], [
        { r: 255, g:   0, b:   0, a: 1 }
        { r: 192, g: 192, b: 192, a: 1 }
        { r:   0, g: 128, b: 128, a: 1 }
        { r: 255, g: 255, b: 255, a: 1 }
      ] ]

    $('#load_test_image_button').click (e) ->
      import_snapshot(test_data_picture)