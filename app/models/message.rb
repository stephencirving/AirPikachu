class Message < ApplicationRecord
  belongs_to :user
  belongs_to :conversation

  validates_presence_of :context, :conversation_id, :user_id

  def message_time
    self.created_at.strftime("%v")
  end
end
