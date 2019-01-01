class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password validations: false
  
  before_create :generate_slug

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length: {minimum: 3}

  def generate_slug
    self.slug = self.username.downcase
  end

  def to_param
    self.slug
  end
end