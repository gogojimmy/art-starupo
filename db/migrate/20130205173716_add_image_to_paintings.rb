class AddImageToPaintings < ActiveRecord::Migration
  def change
    add_column :paintings, :image, :string
  end
end
