class AddSaltToUsers < ActiveRecord::Migration
  def change
    add_column :users, :salt, :string, :index => true
  end
end
