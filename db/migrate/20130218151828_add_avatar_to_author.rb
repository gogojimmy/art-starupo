class AddAvatarToAuthor < ActiveRecord::Migration
  def change
    add_column :authors, :avatar, :string
  end
end
