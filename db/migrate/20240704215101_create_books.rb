class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.date :published_date
      t.string :isbn
      t.string :cover_url

      t.timestamps
    end
  end
end
