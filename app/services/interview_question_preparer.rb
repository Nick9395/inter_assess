class InterviewQuestionPreparer
  def initialize(user:, count:)
    @user = user
    @count = count
  end

  def questions
    ::QuestionMaster.sample(@count).map do |item|
      {
        key: item[:key],
        text: item[:text].gsub("%{profile_hint}", profile_hint)
      }
    end
  end

  private

  def profile_hint
    fragments = education_fragments + work_fragments
    if fragments.empty?
      return "これまでの経験を踏まえて答えてください。"
    end

    "これまでの経歴（#{fragments.join("、")}）を踏まえて答えてください。"
  end

  def education_fragments
    @user.education_entries.map do |entry|
      [ entry.school_name, entry.faculty.presence ].compact.join(" ")
    end
  end

  def work_fragments
    @user.work_entries.map do |entry|
      [ entry.company_description, entry.role.presence ].compact.join("・")
    end
  end
end
