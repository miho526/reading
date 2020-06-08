class Book < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255 }
  has_many :posts
  
  has_many :shelves, class_name: 'Shelf', foreign_key: 'book_id'
  has_many :users, through: :shelves
end
