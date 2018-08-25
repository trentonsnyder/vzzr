class Publisher::MessagesController < Publisher::BaseController
  def create
    @conversation = current_user.company.conversations.find(params[:conversation_id])
    @message = @conversation.messages.new(message_params)
    if @message.save
      ids = @conversation.companies.ids
      filtered_ids = ids - [current_user.company.id]
      filtered_ids.each do |id|
        ActionCable.server.broadcast "company_#{id}_channel",
          { message: {
              id: @message.id,
              body: @message.body,
              company_name: @message.company.name,
              conversation_id: @conversation.id,
              message_time: @message.message_time,
              cover_image_url: current_user.company.cover_image_url,
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
    params.require(:message).permit(:body, :user_id, :conversation_id).merge(user_id: current_user.id, company_id: current_user.company.id)
  end
end
