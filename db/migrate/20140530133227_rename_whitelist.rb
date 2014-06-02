class RenameWhitelist < ActiveRecord::Migration
  def change
    rename_table :whitelist, :whitelists
  end
end
