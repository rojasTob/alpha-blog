require "test_helper"

class CreateArticleTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(username: "janesmith", email: "jane@test.com", password: "test", admin: false)
    @category1 = Category.create(name: "Cooking")
    @category2 = Category.create(name: "Art")
    signin_as(@user)
  end


  test "should get /articles/new and create article" do
    get '/articles/new'
    assert_response :success
    assert_difference 'Article.count', 1 do
      post articles_path, params: {article: {title: "title test", description: "description test", category_ids: [@category1.id,@category2.id]}}
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "Articles", response.body
  end

  test "should get /articles/new and reject invalid article submission" do
    get '/articles/new'
    assert_response :success
    assert_difference 'Article.count', 0 do
      post articles_path, params: {article: {title: "", description: "", category_ids: [@category1.id,@category2.id]}}
    end
    assert_match "errors", response.body
  end
end