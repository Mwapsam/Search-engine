class Article < ApplicationRecord
    validates :title, presence: true, length: { maximum: 150 }
    validates :body, presence: true, length: { maximum: 2500 }
end
