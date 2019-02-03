class Rate < ApplicationRecord
  belongs_to :user
  belongs_to :comment

  validates :user, uniqueness: { scope: :comment, message: 'already rated' }
  validates :rate, inclusion:  { in: [1, -1]}
  scope :for_user, ->(user) { where(user: user) }
end