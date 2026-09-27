class WorkEntry < ApplicationRecord
  include YearMonthAttributable

  belongs_to :user

  year_month_accessor :joined_on, :left_on

  validates :company_description, presence: true
  validates :joined_on, presence: true
  validate :left_on_not_before_joined_on

  private

  def left_on_not_before_joined_on
    return if joined_on.blank? || left_on.blank?
    return if left_on >= joined_on

    errors.add(:left_on, "は入社年月以降にしてください")
  end
end
