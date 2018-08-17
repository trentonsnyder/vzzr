class Publisher::MessagesController < Publisher::BaseController
  def create
    @conversation = current_user.company.conversations.find(params[:conversation_id])
    @message = @conversation.messages.new(message_params)
    if @message.save
      ids = @conversation.companies.ids - [current_user.company.id]
      ids.each do |id|
        ActionCable.server.broadcast "company_#{id}_channel",
          { message: {
            body: @message.body,
            company_chat_name: @message.company_chat_name(current_user.company),
            conversation_id: @conversation.id,
            message_time: @message.message_time,
            direction: @message.direction(current_user),
            to_kind: "creator"
          }, 
          user: current_user
        }
      end
      respond_to do |format|
        format.js
      end
    else
      redirect_to publisher_conversation_url(@conversation.id)
    end
  end

  protected

  def message_params
    params.require(:message).permit(:body, :user_id, :conversation_id).merge(user_id: current_user.id)
  end
end
