require "test_helper"

class InterviewQuestionPreparerTest < ActiveSupport::TestCase
  test "プロフィールの学校名を本問に含める" do
    user = users(:one)
    create_profile!(user)
    user.work_entries.create!(joined_on: Date.new(2022, 4, 1), company_description: "中小向けSaaSの受託開発", role: "バックエンド")

    questions = InterviewQuestionPreparer.new(user: user, count: 5).questions
    assert_equal 5, questions.size
    assert questions.all? { |item| item[:text].include?("東都大学") }
    assert questions.all? { |item| item[:text].include?("中小向けSaaSの受託開発") }
  end
end
