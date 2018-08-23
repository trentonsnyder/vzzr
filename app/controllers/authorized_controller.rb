class AuthorizedController < ApplicationController
  before_action :authenticate_user!
  before_action :check_unread_messages

  protected

  def check_unread_messages
    user_ids = current_user.company.users.ids
    convo_ids = current_user.company.conversations.ids
    @unread = Message.where('messages.conversation_id IN (?) AND messages.user_id IN (?)', convo_ids, user_ids).where(read: false).count > 0
  end
end
