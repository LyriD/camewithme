class AddApproveToWhitelists < ActiveRecord::Migration
  def change
    add_column :whitelists, :approve, :boolean, :index => true
  end
end
