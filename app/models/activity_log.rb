class ActivityLog < ApplicationRecord
  belongs_to :user

  validates :user, presence: :true
  validates :label, presence: :true
end
