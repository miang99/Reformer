require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.new(username: "Trang", email: "trang@mail.com", password: "password")
    
  end
  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should get create" do
    post users_url, params: { user: {
                              username: "Trang", email: "trang@mail.com",
                              password: "password"
    }}
    follow_redirect!
    assert_template 'users/index'
    
  end

end
