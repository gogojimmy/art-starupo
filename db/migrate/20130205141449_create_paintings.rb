class CreatePaintings < ActiveRecord::Migration
  def change
    create_table :paintings do |t|
      t.string :name
      t.date :pub_year
      t.text :description

      t.timestamps
    end
  end
end
