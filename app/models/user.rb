class User < ActiveRecord::Base

  has_many :my_chats, :foreign_key => :owner_id, :class_name => 'Chat'
  has_many :messages, foreign_key: :sender_id


  has_many :whitelists
  has_many :chats, through: :whitelists

end
