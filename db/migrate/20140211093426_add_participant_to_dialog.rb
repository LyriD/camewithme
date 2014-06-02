class AddParticipantToDialog < ActiveRecord::Migration
  def change
    add_column :dialogs, :participant_id, :integer
  end
end
