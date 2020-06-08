class AddReadFlagToShelves < ActiveRecord::Migration[5.2]
  def change
    add_column :shelves, :post_flag, :boolean
  end
end
