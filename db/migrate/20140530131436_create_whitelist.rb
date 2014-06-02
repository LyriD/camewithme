class CreateWhitelist < ActiveRecord::Migration
  def change
    create_table :whitelist do |t|
      t.belongs_to :user
      t.belongs_to :chat
      t.timestamps
    end
  end
end
