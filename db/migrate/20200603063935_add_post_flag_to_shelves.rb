class AddPostFlagToShelves < ActiveRecord::Migration[5.2]
  def change
    add_column :shelves, :post_flag, :boolean, :default => false
  end
end
