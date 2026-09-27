require "test_helper"

class PracticeAnswersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in @user
    create_profile!(@user)
    @practice = PracticeStarter.new(user: @user, question_count: 5).call
  end

  test "回答すると次の質問へ進む" do
    first_question = @practice.current_turn.question_text

    post practice_answers_path(@practice), params: { turn: { answer_text: "ゼミで計量経済を学びました。" } }

    assert_redirected_to practice_path(@practice)
    follow_redirect!
    assert_not_equal first_question, @practice.reload.current_turn.question_text
    assert_select "p", text: /質問 2 \/ 5/
  end

  test "空の回答は送れない" do
    assert_no_changes -> { @practice.current_turn.reload.answer_text } do
      post practice_answers_path(@practice), params: { turn: { answer_text: "   " } }
    end
    assert_response :unprocessable_content
  end

  test "最後の回答で面談が終了する" do
    @practice.turns.each do |turn|
      post practice_answers_path(@practice), params: { turn: { answer_text: "回答です。" } }
    end

    follow_redirect!
    assert @practice.reload.completed?
    assert_select "h1", text: "面談終了"
    assert_select "p", text: "回答です。"
  end
end
