class CreateShelves < ActiveRecord::Migration[5.2]
  def change
    create_table :shelves do |t|
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true
      t.boolean :read_flag, :default => false

      t.timestamps
      t.index [:user_id, :book_id], unique: true
    end
  end
end
