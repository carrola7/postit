class Category < ActiveRecord::Base
  include Sluggable

  has_many :post_categories
  has_many :posts, through: :post_categories

  before_create -> { generate_slug('name') }

  validates :name, presence: true

end