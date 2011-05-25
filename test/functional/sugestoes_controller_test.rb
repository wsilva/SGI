require 'test_helper'

class SugestoesControllerTest < ActionController::TestCase
  setup do
    @sugestao = sugestoes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sugestoes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sugestao" do
    assert_difference('Sugestao.count') do
      post :create, :sugestao => @sugestao.attributes
    end

    assert_redirected_to sugestao_path(assigns(:sugestao))
  end

  test "should show sugestao" do
    get :show, :id => @sugestao.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @sugestao.to_param
    assert_response :success
  end

  test "should update sugestao" do
    put :update, :id => @sugestao.to_param, :sugestao => @sugestao.attributes
    assert_redirected_to sugestao_path(assigns(:sugestao))
  end

  test "should destroy sugestao" do
    assert_difference('Sugestao.count', -1) do
      delete :destroy, :id => @sugestao.to_param
    end

    assert_redirected_to sugestoes_path
  end
end
