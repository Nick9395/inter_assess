class User < ApplicationRecord
  MAX_EDUCATION_ENTRIES = 2
  MAX_WORK_ENTRIES = 3

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :education_entries, -> { order(:position, :id) }, dependent: :destroy, inverse_of: :user
  has_many :work_entries, -> { order(:position, :id) }, dependent: :destroy, inverse_of: :user
  has_many :practices, dependent: :destroy

  def in_progress_practice
    practices.in_progress.first
  end

  accepts_nested_attributes_for :education_entries, allow_destroy: true, reject_if: :blank_education_attrs?
  accepts_nested_attributes_for :work_entries, allow_destroy: true, reject_if: :blank_work_attrs?

  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 50 }
  validate :education_entries_within_limit
  validate :work_entries_within_limit

  before_validation :assign_entry_positions

  def profile_present?
    education_entries.any?(&:persisted?) || work_entries.any?(&:persisted?)
  end

  private

  def blank_education_attrs?(attrs)
    attrs["id"].blank? &&
      attrs["school_name"].blank? &&
      attrs["enrolled_on"].blank? &&
      attrs["faculty"].blank? &&
      attrs["graduated_on"].blank? &&
      attrs["learned"].blank?
  end

  def blank_work_attrs?(attrs)
    attrs["id"].blank? &&
      attrs["company_description"].blank? &&
      attrs["joined_on"].blank? &&
      attrs["left_on"].blank? &&
      attrs["role"].blank? &&
      attrs["achievement"].blank?
  end

  def assign_entry_positions
    education_entries.reject(&:marked_for_destruction?).each_with_index do |entry, index|
      entry.position = index
    end
    work_entries.reject(&:marked_for_destruction?).each_with_index do |entry, index|
      entry.position = index
    end
  end

  def education_entries_within_limit
    count = education_entries.reject(&:marked_for_destruction?).size
    return if count <= MAX_EDUCATION_ENTRIES

    errors.add(:base, "学歴は#{MAX_EDUCATION_ENTRIES}件までです")
  end

  def work_entries_within_limit
    count = work_entries.reject(&:marked_for_destruction?).size
    return if count <= MAX_WORK_ENTRIES

    errors.add(:base, "職歴は#{MAX_WORK_ENTRIES}社までです")
  end
end
