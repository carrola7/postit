class Post < ActiveRecord::Base
  include Voteable
  include Sluggable
  
  belongs_to :creator, foreign_key: :user_id, class_name: 'User'
  has_many :comments, foreign_key: :post_id
  has_many :post_categories
  has_many :categories, through: :post_categories

  before_save -> { generate_slug('title') }

  validates :title, presence: true, length: {minimum: 5}
  validates :url, presence: true, uniqueness: true
  validates :description, presence: true


  

end