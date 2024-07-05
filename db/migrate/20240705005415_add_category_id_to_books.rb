class AddCategoryIdToBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :category_id, :integer
    add_foreign_key :books, :categories
    add_index :books, :category_id
  end
end