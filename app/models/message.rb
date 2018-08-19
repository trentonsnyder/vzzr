class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  has_many :message_read_states, dependent: :destroy

  validates :body,
    presence: true

  after_commit :generate_read_states

  def message_time
    created_at.strftime("%m/%d %l:%M %p")
  end

  def company_chat_name(user_company)
    conversation.companies.where("companies.id != ?", user_company.id).first.name
  end

  def other_company_chat_name(user_company)
    conversation.companies.where("companies.id != ?", user_company.id).first.name
  end

  def direction(current_user)
    if current_user.company.id === user.company.id
      "outbound"
    else
      "inbound"
    end
  end

  protected

  def generate_read_states
    conversation.companies.each do |co|
      if co.id === user_id
        message_read_states.create(company_id: co.id, read_date: Time.current())
      else
        message_read_states.create(company_id: co.id)
      end
    end
  end
end