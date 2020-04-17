class ActivityLog < ApplicationRecord
  belongs_to :user

  validates :user, presence: :true
  validates :label, presence: :true
  validates :started_at, presence: :true
  validates :ended_at, presence: :true

  validates :ended_at, time_greater_than_or_equal_to: :started_at
end
