class Creator::ConversationsController < Creator::BaseController
  def index
    convo_ids = current_user.company.conversations.ids
    @messages = Message.includes(:conversation)
                        .where('messages.id IN (
                            SELECT MAX(messages.id)
                            FROM messages
                            WHERE messages.conversation_id IN (?)
                            GROUP BY messages.conversation_id
                          )', convo_ids)
                          .order(:id)
  end
end
