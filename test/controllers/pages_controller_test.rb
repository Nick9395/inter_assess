require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "トップページが表示される" do
    get root_path
    assert_response :success
    assert_select "h1", text: "Inter_Assess"
    assert_select "dd", text: Rails.env
    assert_select "dd", text: Rails.version
    assert_select "dd", text: RUBY_VERSION
  end
end
