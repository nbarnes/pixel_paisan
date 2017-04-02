MagicLamp.fixture(controller: StaticPagesController) do
  @palettes = Palette.where(is_default: true)
  render 'editor'
end
