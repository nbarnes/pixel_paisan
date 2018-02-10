require 'test_helper'
require 'test_pixels_helper'

class PicturesControllerTest < ActionController::TestCase
  setup do
    @picture = pictures(:gal_picture01)
  end

  test "show" do
    get :show, id: @picture
    assert_response :success
    assert_equal assigns(:picture), @picture
  end

  test "destroy while owning picture" do
    sign_in users(:galactus)
    delete :destroy, id: @picture
    assert_not Picture.exists? @picture.id
    assert_redirected_to gallery_path(@picture.gallery.id)
  end

  test "destroy without owning picture" do
    delete :destroy, id: @picture
    assert Picture.exists? @picture.id
    assert_response :unauthorized
  end

  test "create" do
    sign_in users(:galactus)
    post :create,
      pixels: valid_pixels,
      name: 'new_picture',
      palette_id: palettes(:gals_default_palette).id,
      cell_size: 20
    assert_response :success
  end

  test "create with invalid characters in name" do
    sign_in users(:galactus)
    post :create,
      pixels: valid_pixels,
      name: 'new pic^^tu re',
      palette_id: palettes(:gals_default_palette).id,
      cell_size: 20
    assert_response :success
  end

  test "create with invalid pixel color values" do
    sign_in users(:galactus)
    post :create,
      pixels: invalid_pixels_color_range,
      name: 'invalid_picture',
      palette_id: palettes(:gals_default_palette).id,
      cell_size: 20
    assert_response :bad_request
  end

  test "create with invalid canvas dimensions" do
    sign_in users(:galactus)
    post :create,
      pixels: invalid_pixels_canvas_dimension,
      name: 'invalid_picture',
      palette_id: palettes(:gals_default_palette).id,
      cell_size: 20
    assert_response :bad_request
  end

  test "edit owned picture" do
    sign_in users(:rocket)
    post :edit,
      id: pictures(:rocket_picture01)
    assert_equal assigns(:palettes), [palettes(:gals_default_palette), palettes(:gals_perler_palette), palettes(:rockets_palette1), palettes(:rockets_palette2)]
    assert_response :success
  end

  test "edit somebody else's picture" do
    sign_in users(:rocket)
    post :edit,
      id: pictures(:tony_picture02)
    assert_equal assigns(:palettes), [palettes(:gals_default_palette), palettes(:gals_perler_palette), palettes(:rockets_palette1), palettes(:rockets_palette2)]
    assert_redirected_to editor_path
  end

  test "update" do
    sign_in users(:galactus)
    previous_snapshot_count = @picture.snapshots.size
    post :update,
      id: @picture,
      pixels: valid_pixels,
      name: 'valid_update',
      palette_id: palettes(:gals_default_palette).id,
      cell_size: 20
    @picture.reload
    @picture.snapshots.reload
    assert @picture.name == 'valid_update'
    assert @picture.palette_id == palettes(:gals_default_palette).id
    assert @picture.snapshots.size == (previous_snapshot_count + 1)
    assert_response :success
  end

  test "update without owning picture" do
    post :update,
      id: @picture,
      pixels: valid_pixels,
      name: 'valid_update',
      palette_id: palettes(:gals_default_palette).id,
      cell_size: 20
    assert_response :unauthorized
  end

end
