require "test_helper"

class SignupTest < ActionDispatch::IntegrationTest

  test "get signup form" do
    get '/signup'
    assert_response :success
    assert_match "Sign up for Alpha Blog", response.body
    assert_select "form[action=?]", "/users", count: 1
  end

  test "should display errors and reject invalid user submission" do
    get '/signup'
    assert_response :success
    assert_difference 'User.count', 0 do
      post users_path, params: {user: {username: "", email: "", password: ""}}
    end
    assert_match "errors", response.body
    assert_match "Username can&#39;t be blank.", response.body
    assert_match "Username is too short (minimum is 3 characters).", response.body
    assert_match "Email can&#39;t be blank.", response.body
    assert_match "Email is invalid.", response.body
    assert_match "Password can&#39;t be blank.", response.body

  end

  test "should create new user and redirect to articles list page" do
    get '/signup'
    assert_response :success
    assert_difference 'User.count', 1 do
      post users_path, params: {user: {username: "test-user", email: "test@test.com", password: "test"}}
    end
    follow_redirect!
    assert_response :success
    assert_match "Welcome to the Alpha Blog test-user, you signed up!", response.body
    assert_match "Articles", response.body
  end
end
