$ ->
  $('.front_page.welcome').ready ->

    window.test_data_picutre =
      name: 'test_picture_01'
      picture_id: 42
      cell_size: 13
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