class ChangePubYearTypeForPaintings < ActiveRecord::Migration
  def change
    change_column :paintings, :pub_year, :string
  end
end
