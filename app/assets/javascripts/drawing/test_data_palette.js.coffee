
window.TestPaletteData = (->
  name = 'default'
  colors = [
    { r:   0, g: 255, b: 255, a: 1 }
    { r: 255, g: 255, b: 255, a: 1 }
    { r:   0, g:   0, b: 255, a: 1 }
    { r: 255, g:   0, b: 255, a: 1 }
    { r: 128, g: 128, b: 128, a: 1 }
    { r:   0, g: 128, b:   0, a: 1 }
    { r:   0, g: 255, b:   0, a: 1 }
    { r: 128, g:   0, b:   0, a: 1 }
    { r:   0, g:   0, b: 128, a: 1 }
    { r: 128, g: 128, b:   0, a: 1 }
    { r: 255, g: 165, b:   0, a: 1 }
    { r: 128, g:   0, b: 128, a: 1 }
    { r: 255, g:   0, b:   0, a: 1 }
    { r: 192, g: 192, b: 192, a: 1 }
    { r:   0, g: 128, b: 128, a: 1 }
    { r: 255, g: 255, b: 255, a: 1 }
    { r: 255, g: 255, b:   0, a: 1 }
  ]

  return {
    name: name
    colors: colors
  }
  
)()
