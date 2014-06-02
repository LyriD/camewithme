class Message < ActiveRecord::Base

  belongs_to :user, foreign_key: :sender_id
  belongs_to :chat, foreign_key: :room_id

end
