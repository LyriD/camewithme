class AddRoomIdToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :room_id, :string, :index => true
  end
end
