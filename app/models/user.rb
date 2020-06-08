class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :posts
  has_many :books
  
  has_many :shelves, class_name: 'Shelf', foreign_key: 'user_id'
  has_many :my_books, through: :shelves, source: :book
  
  has_many :favorites, dependent: :destroy
  has_many :likes, through: :favorites, source: :post

  
  def have(book)
    self.shelves.find_or_create_by(book_id: book.id)
  end
  
  def unhave(book)
    shelf = self.shelves.find_by(book_id: book.id)
    shelf.destroy if shelf
  end
  
  def having?(book)
    self.my_books.include?(book)
  end
  
  def posted(book)
    shelf = self.shelves.find_by(book_id: book.id)
    shelf.post_flag = 'true'
    shelf.save
  end
  
  def unpost(post)
    shelf = self.shelves.find_by(book_id: post.book_id)
    shelf.post_flag = 'false'
    shelf.save
  end
  
  def read(book)
    shelf = self.shelves.find_by(book_id: book.id)
    shelf.read_flag = 'true'
    shelf.save
  end
  
  def like(post)
    self.favorites.find_or_create_by(post_id: post.id)
  end
  
  def unlike(post)
    favorite = self.favorites.find_by(post_id: post.id)
    favorite.destroy if favorite
  end
  
  def like?(post)
    self.likes.include?(post)
  end
end