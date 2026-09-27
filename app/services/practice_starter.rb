class PracticeStarter
  def initialize(user:, question_count:)
    @user = user
    @question_count = question_count
  end

  def call
    practice = @user.practices.new(question_count: @question_count, status: ::Practice::IN_PROGRESS)
    return practice unless practice.valid?

    ::Practice.transaction do
      practice.save!
      ::InterviewQuestionPreparer.new(user: @user, count: practice.question_count).questions.each_with_index do |item, index|
        practice.turns.create!(
          kind: "master",
          sequence: index,
          master_key: item[:key],
          question_text: item[:text]
        )
      end
    end

    practice
  end
end
