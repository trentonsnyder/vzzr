class Creator::ConversationsController < Creator::BaseController
  def index
    get_left_bar
  end

  def show
    get_left_bar
    message = Message.find(params[:id])
    @conversation = current_user.company.conversations.find_by(id: message.conversation_id)
    if @conversation.nil?
      redirect_to creator_conversations_path
    else
      @message = @conversation.messages.new()
      @company = @conversation.companies.where("companies.id != ?", current_user.company.id).first
      Message.all.where('user_id NOT IN (?) AND conversation_id = ?', current_user.company.users.ids, @conversation.id).update_all(read: true)
    end
  end

  def publisher
    get_left_bar
    publisher = Company.find(params[:id])
    pub_convo_ids = publisher.conversations.ids
    cu_convo_ids = current_user.company.conversations.ids
    found = pub_convo_ids & cu_convo_ids
    @conversation = Conversation.find_by(id: found.first)
    if @conversation.nil?
      @conversation = Conversation.create()
      @conversation.participants.create(company_id: current_user.company.id)
      @conversation.participants.create(company_id: publisher.id)
    end
    @message = @conversation.messages.new()
    @company = @conversation.companies.where("companies.id != ?", current_user.company.id).first
    render :show
  end

  private

  def get_left_bar
    convo_ids = current_user.company.conversations.ids
    @messages = Message.includes(:conversation)
                        .where('messages.id IN (
                            SELECT MAX(messages.id)
                            FROM messages
                            WHERE messages.conversation_id
                            IN (?)
                            GROUP BY messages.conversation_id
                          )', convo_ids)
                        .order("created_at DESC", "id DESC")
  end

end

