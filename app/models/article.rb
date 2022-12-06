class Article < ApplicationRecord
    include PgSearch::Model

    validates :title, presence: true, uniqueness: true, length: { maximum: 150 }
    validates :body, presence: true, length: { maximum: 2500 }

    scope :sorted, ->{ order(created_at: :asc) }

    pg_search_scope :article_search,
                    against: [:title],
                    using: { tsearch: { prefix: true } }
end
