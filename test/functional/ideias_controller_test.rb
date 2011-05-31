require 'test_helper'

class IdeiasControllerTest < ActionController::TestCase
  setup do
    @ideia_usuario1 = ideias(:one)    
    @ideia_usuario2 = ideias(:three)
  end
  
  # index and all
  test "should get index and all anonymous" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ideias)
    get :all
    assert_response :success
    assert_not_nil assigns(:ideias)
  end  
  test "should get index and all signed in" do
    sign_in usuarios(:usuario2)
    get :index
    assert_response :success
    assert_not_nil assigns(:ideias)
    get :all
    assert_response :success
    assert_not_nil assigns(:ideias)
  end  
  
  # about  
  test "should get about anonymous" do 
    get :about
    assert_response :success        
  end
  test "should get about signed in" do
    sign_in usuarios(:usuario2)
    get :about
    assert_response :success        
  end
 
  # show
  test "should show ideia anonymous" do
    get :show, :id => @ideia_usuario1.to_param
    assert_response :success
  end
  test "should show ideia signed in" do
    sign_in usuarios(:usuario2)
    get :show, :id => @ideia_usuario1.to_param
    assert_response :success
  end 
 
  # new and edit
  test "should not get new and edit anonymous" do
    get :new
    assert_redirected_to new_usuario_session_path
    get :edit, :id => @ideia_usuario1.to_param
    assert_redirected_to new_usuario_session_path
  end
  test "should get new signed in" do
    sign_in usuarios(:usuario2)
    get :new
    assert_response :success
  end
  test "new ideia has to belong to current usuario" do
    sign_in usuarios(:usuario2)
    get :new
    assert assigns(:ideia).usuario_id == usuarios(:usuario2).id, "Ideia does not belong to current usuario"
  end
  test "should get edit to own ideia signed in" do
    sign_in usuarios(:usuario2)
    get :edit, :id => @ideia_usuario2.to_param
    assert_response :success
  end
  test "edited ideia has to belong to current usuario" do
    sign_in usuarios(:usuario2)
    get :edit, :id => @ideia_usuario1.to_param
    assert_redirected_to root_url, "Should be redirected to root url if ideia of other usuario is requested"
    assert_equal 'The ideia you requested could not be found.', flash[:error]
  end
  
  # create
  test "should not create ideia anonymous" do
    assert_no_difference('Ideia.count') do
      post :create, :ideia => @ideia_usuario1.attributes
    end
  end
  test "should not create ideia linked to other usuario" do
    sign_in usuarios(:usuario2)
    post :create, :ideia => { :usuario_id => usuarios(:usuario1).id, :titulo => 'Title', :texto => 'Body' }
    puts assigns(:ideia).usuario_id
    assert assigns(:ideia).usuario_id == usuarios(:usuario2).id, "Ideia does not belong to current usuario"   
  end
  test "should create ideia signed in" do
    sign_in usuarios(:usuario2)
    assert_difference('Ideia.count', 1, "Ideia count has not changed") do
       post :create, :ideia => { :usuario_id => usuarios(:usuario2).id, :titulo => 'Title', :texto => 'Body' }
    end
    assert_redirected_to ideia_path(assigns(:ideia))
    assert_equal 'Ideia was successfully created.', flash[:notice]
  end
  
  # update
  test "should not update ideia anonymous" do  
    put :update, :id => @ideia_usuario1.to_param, :ideia => @ideia_usuario1.attributes
    assert_redirected_to new_usuario_session_path
  end
  test "should update ideia signed in" do
    sign_in usuarios(:usuario2)
    put :update, :id => @ideia_usuario2.to_param, :ideia => @ideia_usuario2.attributes
    assert_redirected_to ideia_path(assigns(:ideia))
  end
  test "should not update ideia linked to other usuario" do
    sign_in usuarios(:usuario2)
    put :update, :id => @ideia_usuario1.to_param, :ideia => @ideia_usuario1.attributes
    assert_redirected_to root_url, "Should be redirected to root url if ideia of other usuario is requested"
    assert_equal 'The ideia you requested could not be found.', flash[:error]
  end

  # destroy
  test "should not destroy ideia anonymous" do
    assert_no_difference('Ideia.count') do
      delete :destroy, :id => @ideia_usuario1.to_param
    end
    assert_redirected_to new_usuario_session_path
  end
  test "should destroy ideia signed in" do
    sign_in usuarios(:usuario2)
    assert_difference('Ideia.count', -1) do
      delete :destroy, :id => @ideia_usuario2.to_param
    end
    assert_redirected_to ideias_path
  end
  test "should not destroy ideia linked to other usuario" do
    sign_in usuarios(:usuario2)
    assert_no_difference('Ideia.count', "Ideia count has changed") do
      delete :destroy, :id => @ideia_usuario1.to_param
    end
    assert_redirected_to root_url, "Should be redirected to root url if ideia of other usuario is requested"
    assert_equal 'The ideia you requested could not be found.', flash[:error]
  end

end
