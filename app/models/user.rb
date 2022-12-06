class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_searches, dependent: :destroy

  validates :username, :email, presence: true, length: { maximum: 250 }
  validate :password_requirements_are_met, on: :create

  def recent_searches
    user_searches.order(created_at: :desc).limit(5)
  end

  def trending_articles
    user_searches.select(:title).group(:title).having("count(*) > 1").size
  end

  def password_requirements_are_met
    rules = {
      " must contain at least one lowercase letter"  => /[a-z]+/,
      " must contain at least one uppercase letter"  => /[A-Z]+/,
      " must contain at least one digit"             => /\d+/,
      " must contain at least one special character" => /[^A-Za-z0-9]+/
    }
  
    rules.each do |message, regex|
      errors.add( :password, message ) unless password.match( regex )
    end
  end
end
