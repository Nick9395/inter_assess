require "test_helper"

class QuestionMasterTest < ActiveSupport::TestCase
  test "よくある質問は10問ある" do
    assert_equal 10, QuestionMaster.size
  end

  test "指定数だけ重複なく取り出せる" do
    sampled = QuestionMaster.sample(7)
    assert_equal 7, sampled.size
    assert_equal 7, sampled.map { |item| item[:key] }.uniq.size
  end
end
