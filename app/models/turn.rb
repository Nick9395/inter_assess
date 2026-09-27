class Turn < ApplicationRecord
  belongs_to :practice

  validates :kind, presence: true
  validates :sequence, presence: true
  validates :question_text, presence: true
  validates :answer_text, presence: true, on: :update
end
