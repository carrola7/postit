class Post < ActiveRecord::Base
  belongs_to :creator, foreign_key: :user_id, class_name: 'User'
  has_many :comments, foreign_key: :post_id
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :votes, as: :voteable

  before_create :generate_slug

  validates :title, presence: true, length: {minimum: 5}
  validates :url, presence: true, uniqueness: true
  validates :description, presence: true

  include CalculateVotes

  def generate_slug
    self.slug = self.title.gsub(' ', '-').downcase
  end

  def to_param
    self.slug
  end
end