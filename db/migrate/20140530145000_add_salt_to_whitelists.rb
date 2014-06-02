class AddSaltToWhitelists < ActiveRecord::Migration
  def change
    add_column :whitelists, :salt, :string
  end
end
