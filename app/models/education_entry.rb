class EducationEntry < ApplicationRecord
  include YearMonthAttributable

  belongs_to :user

  year_month_accessor :enrolled_on, :graduated_on

  validates :school_name, presence: true
  validates :enrolled_on, presence: true
  validate :graduated_on_not_before_enrolled_on

  private

  def graduated_on_not_before_enrolled_on
    return if enrolled_on.blank? || graduated_on.blank?
    return if graduated_on >= enrolled_on

    errors.add(:graduated_on, "は入学年月以降にしてください")
  end
end
