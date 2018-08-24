class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user
  belongs_to :company

  validates :body,
    presence: true

  def message_time
    created_at.strftime("%m/%d %l:%M %p")
  end

  def company_chat_name(user_company)
    conversation.companies.where("companies.id != ?", user_company.id).first.name
  end

  def other_company_chat_name(user_company)
    conversation.companies.where("companies.id != ?", user_company.id).first.name
  end

  def conversation_unread(current_user)
    conversation.messages.where('messages.company_id != ? AND messages.read = false', current_user.company.id).count > 0
  end

  def direction(current_user)
    if current_user.company.id === user.company.id
      "outbound"
    else
      "inbound"
    end
  end

end