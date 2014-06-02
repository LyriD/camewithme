class Chat < ActiveRecord::Base

  belongs_to :user, :foreign_key => :owner_id

  has_many :whitelists

  has_many :users, through: :whitelists
  has_many :messages, :foreign_key => :room_id

end
