require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "ユーザー名は必須" do
    user = User.new(email: "new@example.com", password: "password", password_confirmation: "password")
    assert_not user.valid?
    assert_includes user.errors[:username], "を入力してください"
  end

  test "学歴は2件まで" do
    user = users(:one)
    2.times do |index|
      user.education_entries.build(enrolled_on: Date.new(2018, 4, 1), school_name: "学校#{index}")
    end
    user.education_entries.build(enrolled_on: Date.new(2020, 4, 1), school_name: "余剰")
    assert_not user.valid?
    assert_includes user.errors[:base], "学歴は2件までです"
  end
end
