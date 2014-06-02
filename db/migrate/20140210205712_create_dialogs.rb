class CreateDialogs < ActiveRecord::Migration
  def change
    create_table :dialogs do |t|
      t.integer :user_id, :index => true
      t.integer :conversation_id, :index => true
      t.integer :messages_count, :default => 0

      t.timestamps
    end
  end
end
