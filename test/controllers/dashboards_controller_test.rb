require "test_helper"

class DashboardsControllerTest < ActionDispatch::IntegrationTest
  test "未ログインだとログイン画面へリダイレクトされる" do
    get dashboard_path
    assert_redirected_to new_user_session_path
  end

  test "ログイン中はユーザー画面が表示される" do
    sign_in users(:one)
    get dashboard_path
    assert_response :success
    assert_select "p", text: users(:one).username
    assert_select "button[title='ログアウト']"
  end
end
