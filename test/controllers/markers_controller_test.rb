require 'test_helper'

class MarkersControllerTest < ActionController::TestCase
  setup do
    @marker = markers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:markers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create marker" do
    assert_difference('Marker.count') do
      post :create, marker: { abbr: @marker.abbr, admin: @marker.admin, email: @marker.email, encrypted_password: @marker.encrypted_password, first: @marker.first, last: @marker.last, salt: @marker.salt, scaling: @marker.scaling, shift: @marker.shift }
    end

    assert_redirected_to marker_path(assigns(:marker))
  end

  test "should show marker" do
    get :show, id: @marker
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @marker
    assert_response :success
  end

  test "should update marker" do
    patch :update, id: @marker, marker: { abbr: @marker.abbr, admin: @marker.admin, email: @marker.email, encrypted_password: @marker.encrypted_password, first: @marker.first, last: @marker.last, salt: @marker.salt, scaling: @marker.scaling, shift: @marker.shift }
    assert_redirected_to marker_path(assigns(:marker))
  end

  test "should destroy marker" do
    assert_difference('Marker.count', -1) do
      delete :destroy, id: @marker
    end

    assert_redirected_to markers_path
  end
end
