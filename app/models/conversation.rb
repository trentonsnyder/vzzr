class Conversation < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :participants, dependent: :destroy
  has_many :companies, through: :participants

  def user_ids
    User.where("users.company_id IN (?)", companies.ids).ids
  end
end
