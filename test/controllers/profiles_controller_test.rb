require "test_helper"

class ProfilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in @user
  end

  test "未ログインだとログイン画面へリダイレクトされる" do
    sign_out @user
    get edit_profile_path
    assert_redirected_to new_user_session_path
  end

  test "プロフィール編集画面が表示される" do
    get edit_profile_path
    assert_response :success
    assert_select "h1", text: "プロフィール"
    assert_select "button[form='profile-form']", text: "保存する"
    assert_select "a", text: "ユーザー画面へ"
    assert_select "button", text: "+ 学歴追加"
    assert_select "button", text: "+ 職歴追加"
    assert_select "button[form='profile-delete-form']", count: 0
    assert_select "fieldset[data-slot-list-target='slot']", count: 5
    assert_select "fieldset[data-slot-list-target='slot'][hidden]", count: 3
  end

  test "保存済みがあるときは削除ボタンが出る" do
    @user.education_entries.create!(enrolled_on: Date.new(2018, 4, 1), school_name: "東都大学")
    get edit_profile_path
    assert_response :success
    assert_select "button[form='profile-delete-form']", text: "プロフィールを削除"
    assert_select "form#profile-delete-form"
  end

  test "学歴と職歴を保存できる" do
    assert_difference -> { @user.education_entries.count } => 1, -> { @user.work_entries.count } => 1 do
      patch profile_path, params: {
        user: {
          education_entries_attributes: {
            "0" => {
              enrolled_on: "2018-04",
              school_name: "東都大学",
              faculty: "経済学部",
              graduated_on: "2022-03",
              learned: "計量経済"
            }
          },
          work_entries_attributes: {
            "0" => {
              joined_on: "2022-04",
              company_description: "中小向けSaaSの受託開発",
              role: "バックエンド",
              achievement: "請求機能をリリース"
            }
          }
        }
      }
    end

    assert_redirected_to edit_profile_path
    @user.reload
    assert_equal "東都大学", @user.education_entries.first.school_name
    assert_equal Date.new(2018, 4, 1), @user.education_entries.first.enrolled_on
    assert_equal "中小向けSaaSの受託開発", @user.work_entries.first.company_description
  end

  test "プロフィールをまとめて削除できる" do
    @user.education_entries.create!(enrolled_on: Date.new(2018, 4, 1), school_name: "東都大学")
    @user.work_entries.create!(joined_on: Date.new(2022, 4, 1), company_description: "受託開発")

    delete profile_path
    assert_redirected_to edit_profile_path
    assert_equal 0, @user.education_entries.count
    assert_equal 0, @user.work_entries.count
  end
end
