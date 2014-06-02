class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :body
      t.integer :sender_id, :index => true
      t.boolean :read, :default => false
      t.integer :conversation_id, :index => true

      t.timestamps
    end
  end
end
