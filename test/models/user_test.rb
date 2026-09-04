require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "ユーザー名は必須" do
    user = User.new(email: "new@example.com", password: "password", password_confirmation: "password")
    assert_not user.valid?
    assert_includes user.errors[:username], "を入力してください"
  end
end
