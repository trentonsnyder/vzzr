class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :trackable, :validatable

  # optional because 1st user is created before company.
  belongs_to :company, optional: true
  
  has_many :messages

  def conversations
    Conversation.where('user_1_id = ? OR user_2_id = ?', id, id)
  end
end
