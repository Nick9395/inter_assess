require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "トップページが表示される" do
    get root_path
    assert_response :success
    assert_select "h1", text: "Inter_Assess"
    assert_select "a", text: "利用開始"
    assert_select "a", text: "ログイン"
    assert_select "a", text: "利用規約"
    assert_select "[data-controller='flash']"
    assert_select ".sticky.top-0"
    assert_select "dd", text: Rails.env
    assert_select "dd", text: Rails.version
    assert_select "dd", text: RUBY_VERSION
  end

  test "利用規約が表示される" do
    get terms_path
    assert_response :success
    assert_select "h1", text: "利用規約"
  end
end
