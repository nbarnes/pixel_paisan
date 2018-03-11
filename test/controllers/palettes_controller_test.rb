require 'test_helper'

class PalettesControllerTest < ActionController::TestCase
  setup do
    @palette = palettes(:gals_default_palette)
  end

  test 'should return index of all palettes' do
    get :index
    assert_response :success
    assert_equal assigns(:palettes), Palette.all
  end

  test "should return index of single user's palettes" do
    get :user_index, user_id: users(:rocket)
    assert_response :success
    assert_equal assigns(:palettes), Palette.where(user_id: users(:rocket).id)
  end

  test 'should create new palette' do
    get :new
    assert_response :success
    assert assigns(:palette).is_a? Palette
  end

  test 'should create new palette from params' do
    sign_in users(:tony)
    post :create, palette: { name: 'new_palette' }
    assert_redirected_to palette_path(assigns(:palette).id)
    assert_equal assigns(:palette).name, 'new_palette'
    assert_equal assigns(:palette).user_id, users(:tony).id
  end

  test 'should destroy a palette' do
    sign_in users(:rocket)
    delete :destroy, id: palettes(:rockets_palette1)
    assert_not Palette.exists? palettes(:rockets_palette1).id
    assert_redirected_to user_palettes_path(user_id: users(:rocket).id)
  end

  test "shouldn't destroy another user's palette" do
    sign_in users(:tony)
    delete :destroy, id: palettes(:rockets_palette1)
    assert Palette.exists? palettes(:rockets_palette1).id
    assert_response :unauthorized
  end

  test 'should offer new color page' do
    sign_in users(:rocket)
    get :new_color, id: palettes(:rockets_palette1)
    assert_response :success
  end

  test "shouldn't offer new color page for another user's palette" do
    sign_in users(:tony)
    get :new_color, id: palettes(:rockets_palette1)
    assert_response :unauthorized
  end

  test 'should add new color to a palette' do
    palette = palettes(:tonys_palette)
    assert_not palette.colors.member?('r' => 75, 'g' => 100, 'b' => 150, 'a' => 1)
    sign_in users(:tony)
    post :create_color, id: palette.id, r: 75, g: 100, b: 150, a: 1
    palette.reload
    assert palette.colors.member?('r' => 75, 'g' => 100, 'b' => 150, 'a' => 1)
    assert_redirected_to palette_path(palette.id)
  end

  test "shouldn't add a new color to an unowned palette" do
    sign_in users(:rocket)
    post :create_color, id: palettes(:tonys_palette).id, r: 75, g: 100, b: 150, a: 1
    assert_response :unauthorized
  end

  test 'delete_color' do
    palette = palettes(:gals_perler_palette)
    sign_in users(:galactus)
    assert palette.colors.member?('r' => 151, 'g' => 37, 'b' => 19, 'a' => 1)
    delete :delete_color, id: palette.id, r: 151, g: 37, b: 19, a: 1
    palette.reload
    assert_not palette.colors.member?(r: 151, g: 37, b: 19, a: 1)
    assert_redirected_to palette_path(palette.id)
  end

end
