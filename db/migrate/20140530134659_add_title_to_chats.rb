class AddTitleToChats < ActiveRecord::Migration
  def change
    add_column :chats, :title, :string
  end
end
