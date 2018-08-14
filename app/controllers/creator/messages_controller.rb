class Creator::MessagesController < Creator::BaseController
  def create
    @conversation = current_user.company.conversations.find(params[:conversation_id])
    @message = @conversation.messages.new(message_params)
    if @message.save
      respond_to do |format|
        format.js
      end
    else
      redirect_to creator_conversation_url(@conversation.id)
    end
  end

  protected

  def message_params
    params.require(:message).permit(:body, :user_id, :conversation_id).merge(user_id: current_user.id)
  end
end