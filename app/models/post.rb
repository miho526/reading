class Post < ApplicationRecord
  belongs_to :user
  belongs_to :book
  
  has_many :favorites, dependent: :destroy
  has_many :likes,  through: :favorites, source: :user
end
