class RenameAutherColumnToBooks < ActiveRecord::Migration[5.2]
  def change
    rename_column :books, :auther, :author
  end
end
