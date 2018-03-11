
# rubocop:disable Metrics/MethodLength
def valid_pixels
  return [
    [
      {
        r: 100,
        g: 150,
        b: 200,
        a: 1
      },
      {
        r: 200,
        g: 75,
        b: 50,
        a: 1
      },
      {
        r: 80,
        g: 42,
        b: 49,
        a: 125
      }
    ],
    [
      {
        r: 100,
        g: 150,
        b: 200,
        a: 1
      },
      {
        r: 200,
        g: 75,
        b: 50,
        a: 1
      },
      {
        r: 80,
        g: 42,
        b: 49,
        a: 125
      }
    ],
    [
      {
        r: 100,
        g: 150,
        b: 200,
        a: 1
      },
      {
        r: 200,
        g: 75,
        b: 50,
        a: 1
      },
      {
        r: 80,
        g: 42,
        b: 49,
        a: 125
      }
    ]
  ]
end

def invalid_pixels_color_range
  return [
    [
      {
        r: 400,
        g: 150,
        b: 200,
        a: 1
      },
      {
        r: 200,
        g: 75,
        b: 50,
        a: 1
      },
      {
        r: 80,
        g: 42,
        b: 49,
        a: 125
      }
    ],
    [
      {
        r: 100,
        g: 150,
        b: 200,
        a: 1
      },
      {
        r: 200,
        g: 75,
        b: 50,
        a: 1
      },
      {
        r: 80,
        g: 42,
        b: 49,
        a: 125
      }
    ],
    [
      {
        r: 100,
        g: 150,
        b: 200,
        a: 1
      },
      {
        r: 200,
        g: 75,
        b: 50,
        a: 1
      },
      {
        r: 80,
        g: 42,
        b: 49,
        a: 125
      }
    ]
  ]
end
# rubocop:enable Metrics/MethodLength

# Making a canvas larger than the controller will accept
def invalid_pixels_canvas_dimension
  invalid_canvas = []
  600.times do
    invalid_row = []
    600.times do
      invalid_row.push(
        r: 100,
        g: 150,
        b: 200,
        a: 1
      )
    end
    invalid_canvas.push invalid_row
  end
  return invalid_canvas
end
