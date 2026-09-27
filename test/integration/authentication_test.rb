require "test_helper"

class AuthenticationTest < ActionDispatch::IntegrationTest
  test "サインアップするとユーザー画面へ移動する" do
    assert_difference "User.count", 1 do
      post user_registration_path, params: {
        user: {
          username: "nick",
          email: "nick@example.com",
          password: "password",
          password_confirmation: "password"
        }
      }
    end

    assert_redirected_to dashboard_path
    follow_redirect!
    assert_select "h1", text: "nick"
    assert_select "[data-flash-target='message']"
  end

  test "ログインするとユーザー画面へ移動する" do
    user = users(:one)
    post user_session_path, params: { user: { email: user.email, password: "password" } }
    assert_redirected_to dashboard_path
    follow_redirect!
    assert_select "[data-flash-target='message']"
  end

  test "ログアウトするとトップへ戻る" do
    sign_in users(:one)
    delete destroy_user_session_path
    assert_redirected_to root_path
  end

  test "パスワードリセット案内を送れる" do
    post user_password_path, params: { user: { email: users(:one).email } }
    assert_redirected_to new_user_session_path
    assert_equal 1, ActionMailer::Base.deliveries.size
  end
end
