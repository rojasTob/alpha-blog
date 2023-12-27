require "test_helper"

class CreateCategoryTest < ActionDispatch::IntegrationTest
  setup do
    @admin_user = User.create(username: "janesmith", email: "jane@test.com", password: "test", admin: true)
    signin_as(@admin_user)
  end


  test "get new category form and create category" do
    get '/categories/new'
    assert_response :success
    assert_difference 'Category.count', 1 do
      post categories_path, params: {category: {name: "Cooking"}}
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "Cooking", response.body
  end

  test "get new category form and reject invalid category submission" do
    get '/categories/new'
    assert_response :success
    assert_difference 'Category.count', 0 do
      post categories_path, params: {category: {name: " "}}
    end
    assert_match "errors", response.body
    assert_match "Name can&#39;t be blank.", response.body
    assert_match "Name is too short (minimum is 3 characters).", response.body
  end
end
