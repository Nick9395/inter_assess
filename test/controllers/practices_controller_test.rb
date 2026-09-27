require "test_helper"

class PracticesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in @user
  end

  test "未ログインだとログイン画面へリダイレクトされる" do
    sign_out @user
    get new_practice_path
    assert_redirected_to new_user_session_path
  end

  test "プロフィールがないと開始できない" do
    get new_practice_path
    assert_redirected_to edit_profile_path
  end

  test "プロフィールがあれば開始画面が表示される" do
    create_profile!(@user)
    get new_practice_path
    assert_response :success
    assert_select "h1", text: "面談を始める"
  end

  test "質問数を選んで面談を開始できる" do
    create_profile!(@user)

    assert_difference -> { @user.practices.count } => 1, -> { Turn.count } => 6 do
      post practices_path, params: { practice: { question_count: 6 } }
    end

    practice = @user.practices.order(:id).last
    assert_redirected_to practice_path(practice)
    assert_equal 6, practice.turns.count
    assert_includes practice.turns.first.question_text, "東都大学"
  end

  test "質問数が範囲外だと開始できない" do
    create_profile!(@user)

    assert_no_difference -> { Practice.count } do
      post practices_path, params: { practice: { question_count: 4 } }
    end
    assert_response :unprocessable_content
  end

  test "進行中の面談があると新規開始せず再開する" do
    create_profile!(@user)
    practice = PracticeStarter.new(user: @user, question_count: 5).call

    get new_practice_path
    assert_redirected_to practice_path(practice)

    assert_no_difference -> { Practice.count } do
      post practices_path, params: { practice: { question_count: 5 } }
    end
    assert_redirected_to practice_path(practice)
  end

  test "他人の面談は見られない" do
    create_profile!(@user)
    other = users(:two)
    create_profile!(other)
    practice = PracticeStarter.new(user: other, question_count: 5).call

    get practice_path(practice)
    assert_response :not_found
  end
end
