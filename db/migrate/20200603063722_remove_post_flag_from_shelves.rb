class RemovePostFlagFromShelves < ActiveRecord::Migration[5.2]
  def change
    remove_column :shelves, :post_flag, :boolean
  end
end
