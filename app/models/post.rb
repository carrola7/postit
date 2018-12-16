class Post < ActiveRecord::Base
  belongs_to :user, foreign_key: :user_id
  has_many :comments, foreign_key: :post_id
  has_many :post_categories
  has_many :categories, through: :post_categories
end