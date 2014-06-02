class AddReceiverToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :receiver_id, :integer, :index => true
  end
end
