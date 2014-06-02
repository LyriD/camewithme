class CreateChats < ActiveRecord::Migration
  def change
    create_table :chats do |t|
      t.integer :owner_id
      t.integer :name

      t.timestamps
    end
  end
end
