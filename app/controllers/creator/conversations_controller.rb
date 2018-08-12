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
                          .order("created_at DESC", "id DESC")
  end

  def show
    message = Message.find(params[:id])
    @conversation = current_user.company.conversations.find_by(id: message.conversation_id)
    if @conversation.nil?
      redirect_to creator_conversations_path
    else
      @company = @conversation.companies.where("companies.id != ?", current_user.company.id).first
      respond_to do |format|
        format.js
      end
    end
  end
end
