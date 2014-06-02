class AddPostedToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :posted, :boolean, default: false
  end
end
