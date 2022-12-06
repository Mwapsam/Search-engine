class UserSearch < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, uniqueness: true, length: { maximum: 150 }
end
