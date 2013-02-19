class AddAuthorIdToPaintings < ActiveRecord::Migration
  def change
    add_column :paintings, :author_id, :integer
    add_index :paintings, :author_id
  end
end
