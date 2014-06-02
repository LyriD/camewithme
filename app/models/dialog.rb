class Dialog < ActiveRecord::Base

  # belongs_to :user
  # belongs_to :participant, class_name: 'User', foreign_key: :participant_id

  def update_messages_count
    self.increment!(:messages_count)
  end

  def reset_messages_count
    self.update_attributes(messages_count: 0)
    Message.where(conversation_id: self.conversation_id, receiver_id: self.user_id).map { |m| m.update_attributes(read: true) }
  end

  def self.create_dialog(user_id, participant_id)
    dialog = Dialog.create(user_id: user_id, participant_id: participant_id)
    dialog.update(conversation_id: dialog.id)
    Dialog.create(user_id: participant_id, participant_id: user_id, conversation_id: dialog.id)
    return dialog
  end

  def messages
    Message.where(conversation_id: self.conversation_id, posted: true).order(:updated_at).reverse
  end

  def create_message
    message = Message.create_message(self)
  end

  def send_message(message_body)
    message = self.create_message
    message.update_attributes(sender_id: self.user_id, body: message_body, receiver_id: self.participant_id)
    message.update_dialogs if message.used?
    UserMailer.delay(run_at: 1.minutes.from_now).unread_message_notification(message)
    return message
  end

end
