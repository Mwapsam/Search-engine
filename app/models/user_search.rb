class UserSearch < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { maximum: 150 }
end
