class Practice < ApplicationRecord
  IN_PROGRESS = "in_progress"
  COMPLETED = "completed"
  STATUSES = [ IN_PROGRESS, COMPLETED ].freeze
  QUESTION_COUNT_RANGE = 5..10

  belongs_to :user
  has_many :turns, -> { order(:sequence, :id) }, dependent: :destroy, inverse_of: :practice

  validates :question_count, inclusion: { in: QUESTION_COUNT_RANGE, message: "は5から10で選んでください" }
  validates :status, inclusion: { in: STATUSES }

  scope :in_progress, -> { where(status: IN_PROGRESS) }

  def in_progress?
    status == IN_PROGRESS
  end

  def completed?
    status == COMPLETED
  end

  def current_turn
    turns.where(answer_text: nil).first
  end

  def answered_count
    turns.where.not(answer_text: nil).count
  end

  def complete_if_finished!
    return if turns.where(answer_text: nil).exists?

    update!(status: COMPLETED)
  end
end
